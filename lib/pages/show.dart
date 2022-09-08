import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:version1/pages/search_page.dart';

import '../control_pages/myDrawer.dart';
import '../models/medya.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import 'bilgilerim.dart';
import 'chat.dart';
import 'gelen_kutusu.dart';

class show extends StatefulWidget {
  final MyUser whoData;
  show({
    required this.whoData,
  });
  @override
  State<show> createState() => _showState();
}

Color ppColor = Colors.blue;

class _showState extends State<show> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          flexibleSpace: Container(),
          backgroundColor: Colors.blueAccent,
          elevation: 10,
          toolbarHeight: 80,
          toolbarOpacity: 0.8,
          shadowColor: Colors.black,
          title: Center(
            child: Text(
              "${widget.whoData.userName} ${widget.whoData.soyisim}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(8))),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
          actions: [
            IconButton(
                onPressed: _mesajlaraGit,
                icon: const Icon(
                  Icons.chat,
                  color: Colors.white,
                )),
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: _searchPage,
            ),
            IconButton(
              icon: const Icon(Icons.home, color: Colors.white),
              onPressed: _bilgilerimeGit,
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            child: Column(
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    backgroundImage: controlPP(),
                    radius: 75,
                  ),
                ),
                const SizedBox(width: 8),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) => Sohbet(
                              currentUser: AuthService().user!,
                              konusulanUser: widget.whoData,
                            )));
                  },
                  textColor: Colors.black,
                  title: Text(
                    "${widget.whoData.userName} ${widget.whoData.soyisim}",
                    style: const TextStyle(color: Colors.white),
                  ),
                  leading: CircleAvatar(
                    child: Text(
                      "${widget.whoData.yas}",
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    backgroundColor: ControlColor(),
                  ),
                  subtitle: ControlName(),
                  trailing: const Icon(
                    Icons.message,
                    color: Colors.yellow,
                  ),
                ),
                const SizedBox(width: 18),
                const Divider(
                  height: 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: double.maxFinite,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('${widget.whoData.bio}')),
                      )),
                ),
                const Divider(
                  height: 2,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Bana ait bazı fotoğraflar aşağıdadır.',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: StreamBuilder<
                            DocumentSnapshot<Map<String, dynamic>>>(
                        stream: galeri(),
                        builder: (c, snap) {
                          if (snap.hasData) {
                            MyUser user = MyUser.fromMap(snap.data!.data()!);
                            List<Medya> photos = user.gPic ?? [];

                            return SingleChildScrollView(
                                child: Row(
                              children: photos.map((e) {
                                return GestureDetector(
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(e.url),
                                    radius: 75,
                                    backgroundColor: Colors.white,
                                  ),
                                  onTap: () {
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (builder) => Stack(children: [
                                        AlertDialog(
                                          content: Card(
                                            child: Image.network(e.url),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          child: Card(
                                            elevation: 10,
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(35.0),
                                            ),
                                            child: ClipOval(
                                              child: Material(
                                                color: Colors
                                                    .transparent, // button color
                                                child: InkWell(
                                                  splashColor: Colors
                                                      .red, // inkwell color
                                                  child: const SizedBox(
                                                    width: 35,
                                                    height: 35,
                                                    child: Icon(
                                                      Icons.close,
                                                      color: Colors.black,
                                                      size: 19,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          top: 150,
                                          right: 20,
                                        )
                                      ]),
                                    );
                                  },
                                );
                              }).toList(),
                            ));
                          } else {
                            return Container();
                          }
                        })),
              ],
            ),
          ),
        ),
      ),
    );
  }

  controlPP() {
    if (widget.whoData.image != null) {
      return NetworkImage(widget.whoData.image!);
    } else {
      return AssetImage("images/Logo.png");
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> galeri() {
    var userID = widget.whoData.id;
    var galerinstance =
        FirebaseFirestore.instance.collection('Users').doc(userID).snapshots();
    return galerinstance;
  }

  Text ControlName() {
    if (widget.whoData.il != null) {
      return Text(
        "${widget.whoData.il}/${widget.whoData.ilce} - ${widget.whoData.brans}/${widget.whoData.mevki}",
        style: const TextStyle(color: Colors.blue),
      );
    } else {
      return Text(
        "Hobi kaydı bulunmuyor.",
        style: const TextStyle(color: Colors.orange),
      );
    }
  }

  Color ControlColor() {
    if (widget.whoData.sex == 'Kadın') {
      return ppColor = Colors.pink.shade400;
    } else {
      return ppColor = Colors.blue;
    }
  }

  _mesajlaraGit() {
    return Navigator.of(context)
        .push(CupertinoPageRoute(builder: (context) => const Inbox()));
  }

  _bilgilerimeGit() {
    return Navigator.of(context)
        .push(CupertinoPageRoute(builder: (context) => const bilgilerim()));
  }

  _searchPage() {
    return Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(builder: (context) => const searchPage()),
        ((route) => false));
  }
}

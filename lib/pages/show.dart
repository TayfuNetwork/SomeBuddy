import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/medya.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import 'chat.dart';

class show extends StatefulWidget {
  final MyUser whoData;
  show({
    required this.whoData,
  });
  @override
  State<show> createState() => _showState();
}

class _showState extends State<show> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profili'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  backgroundImage: NetworkImage(widget.whoData.image!),
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
                  backgroundColor: Colors.blue,
                ),
                subtitle: Text(
                  "${widget.whoData.il}/${widget.whoData.ilce} - ${widget.whoData.brans}/${widget.whoData.mevki}",
                  style: const TextStyle(color: Colors.blue),
                ),
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
                child: Text('${widget.whoData.bio}'),
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
                  child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
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
                                                splashColor:
                                                    Colors.red, // inkwell color
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
    );
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> galeri() {
    var userID = widget.whoData.id;
    var galerinstance =
        FirebaseFirestore.instance.collection('Users').doc(userID).snapshots();
    return galerinstance;
  }
}

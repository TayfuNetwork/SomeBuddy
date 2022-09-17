// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:version1/models/konusma.dart';
import 'package:version1/models/user.dart';
import 'package:version1/pages/chat.dart';
import 'package:version1/pages/search_page.dart';
import 'package:version1/pages/show.dart';
import 'package:version1/services/auth_service.dart';

import '../control_pages/myDrawer.dart';
import 'bilgilerim.dart';

class Inbox extends StatefulWidget {
  const Inbox({Key? key}) : super(key: key);

  @override
  State<Inbox> createState() => _InboxState();
}

Color? editIconColor;

class _InboxState extends State<Inbox> {
  @override
  Widget build(BuildContext context) {
    var _userModel = AuthService().user!;

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
            title: const Text(
              "Mesajlar",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(8))),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
            actions: [
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
            child: FutureBuilder<List<Konusma>>(
              future: getAllConversations(_userModel.id!),
              builder: (context, konusmaListesi) {
                if (!konusmaListesi.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  var tumKonusmalar = konusmaListesi.data!;
                  var _saatDakikaDegeri = "";

                  return tumKonusmalar.isEmpty
                      ? const Center(child: Text('Hiç mesajınız yok'))
                      : ListView.builder(
                          itemCount: tumKonusmalar.length,
                          itemBuilder: (context, index) {
                            var oankiKonusma = tumKonusmalar[index];

                            return SingleChildScrollView(
                              child: StreamBuilder<MyUser?>(
                                  stream: getUserFromId(
                                      oankiKonusma.kimle_konusuyor!),
                                  builder: (context, snapshot) {
                                    _saatDakikaDegeri = _saatDakikaGoster(
                                        oankiKonusma.olusturulma_tarihi!);
                                    if (snapshot.hasData) {
                                      var myuser = AuthService().user!.id;
                                      MyUser user = snapshot.data!;
                                      git() {
                                        Navigator.of(context).push(
                                            CupertinoPageRoute(
                                                builder: (context) =>
                                                    show(whoData: user)));
                                      }

                                      ImageProvider _havePhoto() {
                                        if (user.image != null) {
                                          return NetworkImage(user.image!);
                                        } else {
                                          return const AssetImage(
                                              "images/logo.png");
                                        }
                                      }

                                      return Dismissible(
                                        direction: DismissDirection.endToStart,
                                        onDismissed: ((direction) async {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0)),
                                                  title: Center(
                                                    child: const Text(
                                                      "Mesajlar silinecek",
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        TextButton(
                                                            onPressed:
                                                                () async {
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      "konusmalar")
                                                                  .doc(
                                                                      "${myuser}--${user.id}")
                                                                  .delete();

                                                              var collection = FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'konusmalar')
                                                                  .doc(
                                                                      "${myuser}--${user.id}")
                                                                  .collection(
                                                                      "mesajlar");
                                                              var snapshots =
                                                                  await collection
                                                                      .get();
                                                              for (var doc
                                                                  in snapshots
                                                                      .docs) {
                                                                await doc
                                                                    .reference
                                                                    .delete();
                                                              }

                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                              "Sil",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blue),
                                                            )),
                                                        TextButton(
                                                          onPressed: () {
                                                            _konusmalariYenile();
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                              "Vazgeç",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blue)),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              });
                                        }),
                                        key: UniqueKey(),
                                        child: Card(
                                          color: Colors.green,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(80),
                                                  topRight: Radius.circular(80),
                                                  bottomLeft:
                                                      Radius.circular(80),
                                                  bottomRight:
                                                      Radius.circular(80))),
                                          child: ListTile(
                                              title: Text(user.userName!),
                                              subtitle: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  children: [
                                                    kimden(oankiKonusma
                                                        .sonMesajBenimMi),
                                                    Text(oankiKonusma
                                                        .son_yollanan_mesaj!),
                                                    Text("..."),
                                                    Text(_saatDakikaDegeri),
                                                  ],
                                                ),
                                              ),
                                              leading: GestureDetector(
                                                onTap: git,
                                                child: CircleAvatar(
                                                  backgroundImage: _havePhoto(),
                                                ),
                                              ),
                                              onTap: () async {
                                                await Navigator.of(context)
                                                    .push(CupertinoPageRoute(
                                                        builder: (context) =>
                                                            Sohbet(
                                                              currentUser:
                                                                  _userModel,
                                                              konusulanUser:
                                                                  user,
                                                            )));
                                              }),
                                        ),
                                      );
                                    } else {
                                      return const SizedBox(width: 20);
                                    }
                                  }),
                            );
                          });
                }
              },
            ),
          )),
    );
  }

  String _saatDakikaGoster(Timestamp? date) {
    var _formater = DateFormat.Hm();
    var _formatlanmisTarih = _formater.format(date!.toDate());
    return _formatlanmisTarih;
  }

  Future<Null> _konusmalariYenile() async {
    setState(() {});
    await Future.delayed(const Duration(seconds: 1));
    return null;
  }

  _bilgilerimeGit() {
    return Navigator.of(context)
        .push(CupertinoPageRoute(builder: (context) => bilgilerim()));
  }

  _searchPage() {
    return Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(builder: (context) => const searchPage()),
        ((route) => false));
  }

  kimden(bendenMi) {
    var user = AuthService().user!;
    if (bendenMi == user.id) {
      return Text(
        "Gönderilen: ",
        style: TextStyle(color: Colors.white),
      );
    } else {
      return Text("Gelen: ", style: TextStyle(color: Colors.white));
    }
  }
}

Future<List<Konusma>> getAllConversations(String userID) async {
  QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
      .instance
      .collection("konusmalar")
      .where("konusma_sahibi", isEqualTo: userID)
      .orderBy("olusturulma_tarihi", descending: true)
      .get();

  List<Konusma> tumKonusmalar = [];

  for (DocumentSnapshot<Map<String, dynamic>> tekKonusma
      in querySnapshot.docs) {
    if (tekKonusma.data() != null) {
      Konusma _tekKonusma = Konusma.fromMap(tekKonusma.data()!);

      tumKonusmalar.add(_tekKonusma);
    }
  }
  return tumKonusmalar;
}

Stream<MyUser?> getUserFromId(String id) {
  return FirebaseFirestore.instance
      .collection("Users")
      .doc(id)
      .snapshots()
      .map((e) {
    if (e.data() == null) {
      return null;
    }
    return MyUser.fromMap(e.data()!);
  }).distinct();
}

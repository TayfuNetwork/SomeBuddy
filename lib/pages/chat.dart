// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:version1/pages/gelen_kutusu.dart';
import 'package:version1/pages/search_page.dart';

import 'package:version1/pages/show.dart';
import 'package:version1/services/auth_service.dart';

import '../control_pages/myDrawer.dart';
import '../models/mesaj.dart';
import '../models/user.dart';
import 'bilgilerim.dart';

// ignore: must_be_immutable
class Sohbet extends StatefulWidget {
  final MyUser currentUser;
  late MyUser konusulanUser;

  Sohbet({
    Key? key,
    required this.currentUser,
    required this.konusulanUser,
  }) : super(key: key);

  @override
  State<Sohbet> createState() => _SohbetState();
}

Color? statu;
var _mesajController = TextEditingController();
ScrollController _scrollController = ScrollController();

class _SohbetState extends State<Sohbet> {
  @override
  Widget build(BuildContext context) => SafeArea(
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
              "Sohbet",
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
          body: Center(
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder<List<Mesaj>>(
                    stream: getMessages(
                        widget.currentUser.id!, widget.konusulanUser.id!),
                    builder: (context, StreamMesajlarlistesi) {
                      if (!StreamMesajlarlistesi.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      List<Mesaj>? tumMesajar = StreamMesajlarlistesi.data;
                      return ListView.builder(
                          reverse: true,
                          controller: _scrollController,
                          itemBuilder: (context, index) {
                            return _konusmaBalonuOlustur(tumMesajar![index]);
                          },
                          itemCount: tumMesajar?.length);
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 8, left: 8),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: _mesajController,
                          cursorColor: Colors.blueGrey,
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Mesajınızı yazın',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 4,
                        ),
                        child: FloatingActionButton(
                          elevation: 0,
                          backgroundColor: stateColor(),
                          child: const Icon(
                            Icons.navigation,
                            size: 35,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            if (_mesajController.text.trim().length > 0) {
                              Mesaj _kaydedilecekMesaj = Mesaj(
                                kimden: widget.currentUser.id!,
                                kime: widget.konusulanUser.id!,
                                bendenMi: true,
                                mesaj: _mesajController.text,
                              );
                              _mesajController.clear();
                              await AuthService.saveMessage(_kaydedilecekMesaj);
                              /*  NotificationService().sendPushMessage(
                                  widget.konusulanUser.token,
                                  widget.currentUser.userName!,
                                  _mesajController.text); */
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _konusmaBalonuOlustur(Mesaj oankiMesaj) {
    Color _gelenMesajRenk = Colors.green;
    Color _gidenMesajRenk = Theme.of(context).primaryColor;
    var _saatDakikaDegeri = "";
    try {
      _saatDakikaDegeri = _saatDakikaGoster(oankiMesaj.date ?? Timestamp(1, 1));
    } catch (e) {}
    var _benimMesajimMi = oankiMesaj.bendenMi;
    if (_benimMesajimMi) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: _gidenMesajRenk,
                    ),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(4),
                    child: Text(
                      oankiMesaj.mesaj,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Text(_saatDakikaDegeri),
              ],
            )
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: _havePhoto(),
                ),
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: _gelenMesajRenk,
                    ),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(4),
                    child: Text(oankiMesaj.mesaj),
                  ),
                ),
                Text(_saatDakikaDegeri),
              ],
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      );
    }
  }

  _bilgilerimeGit() {
    return Navigator.of(context)
        .push(CupertinoPageRoute(builder: (context) => bilgilerim()));
  }

  _mesajlaraGit() {
    return Navigator.of(context)
        .push(CupertinoPageRoute(builder: (context) =>  Inbox()));
  }

  _searchPage() {
    return Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(builder: (context) => const searchPage()),
        ((route) => false));
  }

  String _saatDakikaGoster(Timestamp? date) {
    var _formater = DateFormat.Hm();
    var _formatlanmisTarih = _formater.format(date!.toDate());
    return _formatlanmisTarih;
  }

  Color stateColor() {
    if (widget.currentUser.sex == 'Kadın') {
      Color statu = Colors.pink;
      return statu;
    } else {
      Color statu = Colors.blue;
      return statu;
    }
  }

  _havePhoto() {
    if (widget.konusulanUser.image != null) {
      return NetworkImage(widget.konusulanUser.image!);
    } else {
      return const AssetImage("images/logo.png");
    }
  }

  showNavigation() {
    return Navigator.of(context).push(CupertinoPageRoute(
        builder: (context) => show(
              whoData: widget.konusulanUser,
            )));
  }
}

Stream<List<Mesaj>> getMessages(String currentUserID, String konusulanUserID) {
  var snapShot = FirebaseFirestore.instance
      .collection("konusmalar")
      .doc(currentUserID + "--" + konusulanUserID)
      .collection("mesajlar")
      .orderBy("date", descending: true)
      .snapshots();
  return snapShot.map((mesajListesi) =>
      mesajListesi.docs.map((mesaj) => Mesaj.fromMap(mesaj.data())).toList());
}

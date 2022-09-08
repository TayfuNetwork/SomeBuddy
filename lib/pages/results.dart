import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:version1/control_pages/myDrawer.dart';
import 'package:version1/models/user.dart';
import 'package:version1/pages/gelen_kutusu.dart';
import 'package:version1/pages/chat.dart';
import 'package:version1/pages/search_page.dart';
import 'package:version1/pages/show.dart';
import 'package:version1/services/auth_service.dart';
import 'package:version1/services/search_service.dart';

import 'bilgilerim.dart';

// ignore: camel_case_types, must_be_immutable
class Results extends StatefulWidget {
  final String il;
  final String ilce;
  final String brans;
  final String mevki;
  Results(
      {Key? key,
      required this.sIcon,
      required this.ppColor,
      required this.brans,
      required this.il,
      required this.ilce,
      required this.mevki})
      : super(key: key);

  @override
  State<Results> createState() => _ResultsState();
  Color ppColor;
  Icon sIcon;
}

// ignore: camel_case_types
class _ResultsState extends State<Results> {
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
          title: const Text(
            "Partner Adayları",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
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
          width: double.maxFinite,
          padding: const EdgeInsets.all(2),
          margin: const EdgeInsets.all(2),
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: SearchService().searchStream(
                widget.il, widget.ilce, widget.brans, widget.mevki),
            builder: (c, snap) {
              if (snap.hasData) {
                List<MyUser> users = snap.data!.docs
                    .map((e) => MyUser.fromMap(e.data()))
                    .toList();

                if (users.length == 1) {
                  if (users.any((e) => e.id == AuthService().user!.id)) {
                    return const Center(
                      child:
                          Text("Malesef, bu kriterlerdeki tek üyemiz sizsiniz"),
                    );
                  }
                }

                if (users.isEmpty) {
                  return Center(
                    child: Container(
                      child: const Text(
                          "Malesef, bu kriterlere uygun bir üyemiz yok"),
                    ),
                  );
                }
                users.removeWhere((e) => e.id == AuthService().user!.id);

                return SingleChildScrollView(
                  child: Column(
                    children: users.map((e) {
                      if (e.sex == 'Kadın') {
                        widget.ppColor = Colors.pink.shade400;
                      } else {
                        widget.ppColor = Colors.blue;
                      }
                      if (e.premium == true) {
                        widget.sIcon =
                            const Icon(Icons.person, color: Colors.red);
                      } else {
                        widget.sIcon = const Icon(
                          Icons.message,
                          color: Colors.blue,
                        );
                      }
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ListTile(
                          title: Text(
                            "${e.userName} ${e.soyisim}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          leading: CircleAvatar(
                            child: Text(
                              e.yas.toString(),
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                            backgroundColor: widget.ppColor,
                          ),
                          subtitle: Text(
                            "${e.il}/ ${e.ilce} - ${e.brans}/ ${e.mevki}",
                            style: const TextStyle(color: Colors.blue),
                          ),
                          trailing: widget.sIcon,
                          onTap: () {
                            if (e.premium == true) {
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (context) => show(
                                        whoData: e,
                                      )));
                            } else {
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (context) => Sohbet(
                                        currentUser: AuthService().user!,
                                        konusulanUser: e,
                                      )));
                            }
                          },
                        ),
                      );
                    }).toList(),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
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

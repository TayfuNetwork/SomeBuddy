import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:version1/control_pages/myDrawer.dart';
import 'package:version1/models/user.dart';
import 'package:version1/pages/gelen_kutusu.dart';
import 'package:version1/pages/chat.dart';
import 'package:version1/pages/private_profil.dart';
import 'package:version1/pages/show.dart';
import 'package:version1/services/auth_service.dart';
import 'package:version1/services/search_service.dart';

// ignore: camel_case_types
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
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: const Text('Arama Sonuçları'),
        actions: [
          IconButton(
            icon: const Icon(Icons.chat),
            onPressed: _mesajlaraGit,
          ),
        ],
      ),
      body: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(color: Colors.grey, blurRadius: 6),
            ]),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: SearchService()
              .searchStream(widget.il, widget.ilce, widget.brans, widget.mevki),
          builder: (c, snap) {
            if (snap.hasData) {
              List<MyUser> users =
                  snap.data!.docs.map((e) => MyUser.fromMap(e.data())).toList();

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
                  // ignore: avoid_unnecessary_containers
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
                    return ListTile(
                      title: Text(
                        "${e.userName} ${e.soyisim}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
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
                        "${e.il}, ${e.ilce}, ${e.brans}, ${e.mevki}",
                        style: const TextStyle(color: Colors.black),
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
    );
  }

  _mesajlaraGit() {
    return Navigator.of(context)
        .push(CupertinoPageRoute(builder: (context) => const Inbox()));
  }
}

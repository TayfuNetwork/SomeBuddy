import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:version1/control_pages/myDrawer.dart';
import 'package:version1/models/user.dart';
import 'package:version1/control_pages/badge_goster.dart';
import 'package:version1/pages/search_page.dart';
import 'package:version1/pages/show.dart';
import 'package:version1/services/auth_service.dart';
import 'package:version1/services/search_service.dart';
import 'bilgilerim.dart';

// ignore: camel_case_types, must_be_immutable
class Results2 extends StatefulWidget {
  final String il;
  final String ilce;
  final String brans;
  final String mevki;
  final String sex;
  Results2(
      {Key? key,
      required this.sex,
      required this.sIcon,
      required this.ppColor,
      required this.brans,
      required this.il,
      required this.ilce,
      required this.mevki})
      : super(key: key);

  @override
  State<Results2> createState() => _Results2State();
  Color ppColor;
  Icon sIcon;
}

// ignore: camel_case_types
class _Results2State extends State<Results2> {
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
          title: Text(
            "ResultPageAppbarTitle".tr(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(8))),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
          actions: [
            baddge(),
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
            stream: SearchService2().searchStream1(
                widget.il, widget.ilce, widget.brans, widget.mevki, widget.sex),
            builder: (c, snap) {
              if (snap.hasData) {
                List<MyUser> users = snap.data!.docs
                    .map((e) => MyUser.fromMap(e.data()))
                    .toList();

                if (users.length == 1) {
                  if (users.any((e) => e.id == AuthService().user!.id)) {
                    return Center(
                      child: Column(
                        children: [
                          Text(widget.il +
                              "/ " +
                              widget.ilce +
                              "/ " +
                              widget.brans +
                              "/ " +
                              widget.mevki),
                          Text("BuKriterdeTekUye".tr()),
                        ],
                      ),
                    );
                  }
                }

                if (users.isEmpty) {
                  return Center(
                    child: Container(
                      child: Column(
                        children: [
                          Text(widget.il +
                              "/ " +
                              widget.ilce +
                              "/ " +
                              widget.brans +
                              "/ " +
                              widget.mevki +
                              "/ " +
                              widget.sex),
                           Text(
                              "BuKriterdeUyeYok".tr()),
                        ],
                      ),
                    ),
                  );
                }
                users.removeWhere((e) => e.id == AuthService().user!.id);

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(widget.il +
                          "/ " +
                          widget.ilce +
                          "/ " +
                          widget.brans +
                          "/ " +
                          widget.mevki +
                          "/ " +
                          widget.sex),
                      Column(
                        children: users.map((e) {
                          if (e.sex == 'Female'|| e.sex =='Kadın') {
                            widget.ppColor = Colors.pink.shade400;
                          } else {
                            widget.ppColor = Colors.blue;
                          }
                          if (e.premium == false) {
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
                              subtitle: SingleChildScrollView(
                                child: Text(
                                  "${e.bio}",
                                  style: const TextStyle(color: Colors.blue),
                                ),
                              ),
                              trailing: widget.sIcon,
                              onTap: () {
                                Navigator.of(context).push(CupertinoPageRoute(
                                    builder: (context) => show(
                                          whoData: e,
                                        )));

                                /* Navigator.of(context).push(CupertinoPageRoute(
                                      builder: (context) => Sohbet(
                                            currentUser: AuthService().user!,
                                            konusulanUser: e,
                                          ))); */
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ],
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

  _bilgilerimeGit() {
    return Navigator.of(context)
        .push(CupertinoPageRoute(builder: (context) => bilgilerim()));
  }

  _searchPage() {
    return Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(builder: (context) => const searchPage()),
        ((route) => false));
  }
}

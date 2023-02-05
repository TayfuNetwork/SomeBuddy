import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:version1/control_pages/badge_goster.dart';
import 'package:version1/pages/search_page.dart';
import 'package:version1/services/ad_helper.dart';
import '../control_pages/myDrawer.dart';
import '../models/medya.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import 'bilgilerim.dart';
import 'chat.dart';

class show extends StatefulWidget {
  final MyUser whoData;
  show({
    required this.whoData,
  });
  @override
  State<show> createState() => _showState();
}

bool? rewardP = false;
Color ppColor = Colors.blue;
double boyut = 75;

@override
void initState() {
  if (adHelper.interstitialAd != null) {
    adHelper.interstitialAd;
  }
}

@override
void dispose() {}

class _showState extends State<show> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: MyDrawer(),
        appBar: AppBar(
          toolbarHeight: 70,
          elevation: 0,
          backgroundColor: Colors.blueAccent,
          title: Center(
            child: Text(
              "${widget.whoData.userName}",
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
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 220, 222, 238),
                  Color.fromARGB(255, 76, 65, 147)
                ], end: Alignment.topRight, begin: Alignment.bottomRight),
                color: Color.fromARGB(255, 163, 215, 231)
                ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: StreamBuilder(
                stream: getUserr(widget.whoData.id!),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: Text("Bir Sorun Oluştu"));
                  }
                  MyUser izlenen = MyUser.fromMap(snapshot.data.data()!);

                  Stream<DocumentSnapshot<Map<String, dynamic>>> galeri() {
                    var userID = izlenen.id;
                    var galerinstance = FirebaseFirestore.instance
                        .collection('Users')
                        .doc(userID)
                        .snapshots();
                    return galerinstance;
                  }

                  Text ControlName() {
                    if (izlenen.il != null) {
                      return Text(
                        "${izlenen.il}/${izlenen.ilce} - ${izlenen.brans}/${izlenen.mevki}",
                        style: const TextStyle(color: Colors.yellow),
                      );
                    } else {
                      return Text(
                        "HobiKaydiBulunmuyor".tr(),
                        style: const TextStyle(color: Colors.orange),
                      );
                    }
                  }

                  Color ControlColor() {
                    if (izlenen.sex == 'Female' || izlenen.sex == 'Kadın') {
                      return ppColor = Colors.pink.shade400;
                    } else {
                      return ppColor = Colors.blue;
                    }
                  }

                  git() {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) => Sohbet(
                              currentUser: AuthService().user!,
                              konusulanUser: izlenen,
                            )));
                  }

                  takipteMi() {
                    bool? tamamMi =
                        AuthService().user?.takip!.contains(izlenen.id);

                    tamamMi;

                    if (!tamamMi!) {
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(color: Colors.grey, blurRadius: 6),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Hobidaş Değil".tr(),
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Hobidaş".tr(),
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      );
                    }
                  }

                  kendiniCikar() {
                    if (izlenen.geriTakip != null) {
                      if (izlenen.geriTakip!.contains(AuthService().user!.id)) {
                        izlenen.geriTakip!.removeWhere(
                            (element) => element == AuthService().user!.id!);
                        AuthService()
                            .updateOtherUser(izlenen.id!, izlenen.geriTakip!);
                      }
                    } else {
                      null;
                    }
                  }

                  return Container(
                    child: Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              backgroundImage: controlPP(),
                              radius: 75,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ListTile(
                          onTap: () {
                            bool? tamamMi =
                                AuthService().user?.takip!.contains(izlenen.id);
                            if (!tamamMi!) {
                              AuthService().user?.takip!.add(izlenen.id!);
                              AuthService().updateUser(AuthService().user!);

                              izlenen.geriTakip!.add(AuthService().user!.id!);
                              AuthService().updateOtherUser(
                                  izlenen.id!, izlenen.geriTakip!);
                            } else {
                              AuthService().user!.takip!.removeWhere(
                                  (element) => element == izlenen.id!);
                              AuthService().updateUser(AuthService().user!);

                              if (izlenen.geriTakip != null) {
                                kendiniCikar();

                                AuthService().updateOtherUser(
                                    izlenen.id!, izlenen.geriTakip!);
                              } else {}
                            }
                          },
                          textColor: Colors.black,
                          title: Text(
                            "${izlenen.userName} ${izlenen.soyisim}",
                            style: const TextStyle(color: Colors.white),
                          ),
                          leading: CircleAvatar(
                            child: Text(
                              "${izlenen.yas}",
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                            backgroundColor: ControlColor(),
                          ),
                          trailing: takipteMi(),
                          subtitle: ControlName(),
                        ),
                        const SizedBox(width: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "${("Takipte").tr()}: ${(izlenen.takip!.length)} ",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                                "${("Takip Eden").tr()}: ${izlenen.geriTakip!.length} ",
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
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
                                child: Center(child: Text('${izlenen.bio}')),
                              )),
                        ),
                        const Divider(
                          height: 5,
                        ),
                        SizedBox(height: 20),
                        SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: StreamBuilder<
                                    DocumentSnapshot<Map<String, dynamic>>>(
                                stream: galeri(),
                                builder: (c, snap) {
                                  if (snap.hasData) {
                                    MyUser user =
                                        MyUser.fromMap(snap.data!.data()!);
                                    List<Medya> photos = user.gPic ?? [];
                                    return SingleChildScrollView(
                                        child: Row(
                                      children: photos.map((e) {
                                        return GestureDetector(
                                          child: CircleAvatar(
                                            backgroundImage:
                                                NetworkImage(e.url),
                                            radius: 75,
                                            backgroundColor: Colors.white,
                                          ),
                                          onTap: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (builder) =>
                                                  Stack(children: [
                                                AlertDialog(
                                                  backgroundColor: Colors.white,
                                                  content: Card(
                                                    child: Image.network(e.url),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  child: Card(
                                                    elevation: 10,
                                                    color: Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              35.0),
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
                                                              color:
                                                                  Colors.black,
                                                              size: 19,
                                                            ),
                                                          ),
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
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
                        SizedBox(height: 20),
                        CircleAvatar(
                          radius: 70,
                          child: GestureDetector(
                            onTap: () async {
                              if (adHelper.rewardedAd != null) {
                                await adHelper.showInterstitialAd((p0) {
                                  git();
                                });
                              } else {
                                await git();
                              }
                            },
                            child: Icon(
                              Icons.email_rounded,
                              size: boyut,
                              color: Colors.red,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }

  controlPP() {
    if (widget.whoData.image != null) {
      return NetworkImage(widget.whoData.image!);
    } else {
      return AssetImage("images/logo.png");
    }
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

  Stream getUserr(String currentUserID) {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUserID)
        .snapshots(includeMetadataChanges: false);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
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
                      bool? tamamMi = AuthService()
                          .user
                          ?.takip!
                          .contains(widget.whoData.id);
                      if (!tamamMi!) {
                        takibeAl();
                      } else {
                        takiptenCikar();
                      }
                    },
                    textColor: Colors.black,
                    title: Text(
                      "${widget.whoData.userName} ${widget.whoData.soyisim}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    leading: CircleAvatar(
                      child: Text(
                        "${widget.whoData.yas}",
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
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
                        "${("Takipte").tr()}: ${(takipedilen().toString())} ",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text("${("Takip Eden")}: ${takipeden().toString()} ",
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
                          child: Center(child: Text('${widget.whoData.bio}')),
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
                                            backgroundColor: Colors.white,
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
                      onLongPress: () async {
                        setState(() {
                          boyut = 95;
                        });
                        await Future.delayed(Duration(seconds: 1));
                        setState(() {
                          boyut = 75;
                        });
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
      return AssetImage("images/logo.png");
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
    if (widget.whoData.sex == 'Female' || widget.whoData.sex == 'Kadın') {
      return ppColor = Colors.pink.shade400;
    } else {
      return ppColor = Colors.blue;
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

  git() {
    Navigator.of(context).push(CupertinoPageRoute(
        builder: (context) => Sohbet(
              currentUser: AuthService().user!,
              konusulanUser: widget.whoData,
            )));
  }

  takipteMi() {
    bool? tamamMi = AuthService().user?.takip!.contains(widget.whoData.id);
    setState(() {
      tamamMi;
    });
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

  takibeAl() {
    AuthService().user?.takip!.add(widget.whoData.id!);
    AuthService().updateUser(AuthService().user!);
    bool? tamamMi = AuthService().user?.takip!.contains(widget.whoData.id);
    if (widget.whoData.geriTakip != null) {
      setState(() {
        tamamMi;
        kendiniEkle();
        takipeden();
        takipedilen();
      });
    } else {}
  }

  takiptenCikar() {
    AuthService()
        .user!
        .takip!
        .removeWhere((element) => element == widget.whoData.id!);
    AuthService().updateUser(AuthService().user!);
    bool? tamamMi = AuthService().user?.takip!.contains(widget.whoData.id);
    if (widget.whoData.geriTakip != null) {
      setState(() {
        tamamMi;
        kendiniCikar();
        takipeden();
        takipedilen();
      });
    } else {
      int takipte = 0;
      takipteMi();
      return takipte;
    }
  }

  int takipedilen() {
    if (widget.whoData.takip != null) {
      List? a = widget.whoData.takip;
      return a!.length;
    } else {
      List? a = widget.whoData.takip;
      return a!.length;
    }
  }

  int takipeden() {
    if (widget.whoData.geriTakip != null) {
      List? Geritakipte = widget.whoData.geriTakip;
      return Geritakipte!.length;
    } else {
      return 0;
    }
  }

  kendiniEkle() {
    if (widget.whoData.geriTakip != null) {
      widget.whoData.geriTakip!.add(AuthService().user!.id!);
      AuthService()
          .updateOtherUser(widget.whoData.id!, widget.whoData.geriTakip!);
    } else {
      ;
    }
  }

  kendiniCikar() {
    if (widget.whoData.geriTakip != null) {
      widget.whoData.geriTakip!
          .removeWhere((element) => element == AuthService().user!.id!);
      AuthService()
          .updateOtherUser(widget.whoData.id!, widget.whoData.geriTakip!);
    } else {
      null;
    }
  }
}

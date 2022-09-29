// ignore: file_names
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:version1/pages/usage.dart';
import '../models/user.dart';
import '../pages/private_profil.dart';
import '../pages/sign_in_page.dart';
import '../services/auth_service.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String? url = AuthService().user?.image;
  MyUser get user => AuthService().user!;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: <Color>[Colors.deepOrange, Colors.orange]),
                ),
                accountName: Text(user.userName! + ' ' + user.soyisim!,
                    style: const TextStyle(
                        fontSize: 20, fontStyle: FontStyle.italic)),
                accountEmail: Text(user.email!),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: _imageController(),
                  radius: 95,
                  backgroundColor: Colors.white,
                )),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.person,
                    ),
                    title: Text(
                      "Profil".tr(),
                      style: TextStyle(fontSize: 15),
                    ),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      _privateprofil();
                    },
                  ),
                  /* ListTile(
                      leading: const Icon(Icons.star),
                      title: const Text("PREMIUM DETAYLARI",
                          style: TextStyle(fontSize: 15)),
                      trailing: const Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) => HomePage()));
                      }), */
                  /* ListTile(
                      leading: const Icon(Icons.safety_divider),
                      title: const Text("GÖRÜŞ - ÖNERİ BİLDİRİN",
                          style: TextStyle(fontSize: 12)),
                      trailing: const Icon(Icons.keyboard_arrow_right),
                      onTap: () {}), */
                  ListTile(
                      leading: const Icon(Icons.video_collection_outlined),
                      title: Text("UsageAppbarTitle".tr(),
                          style: TextStyle(fontSize: 12)),
                      trailing: const Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) => const usage()));
                      }),
                  ListTile(
                      leading: const Icon(Icons.no_accounts),
                      title: Text(
                        "CikisYap".tr(),
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                      trailing: const Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        _cikisYap();
                      }),
                  /* ListTile(
                      leading: const Icon(Icons.language),
                      title: const Text("DİLİ DEĞİŞ",
                          style: TextStyle(fontSize: 12)),
                      trailing: const Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) =>
                                aaaaaaaaa()));
                      }), */
                  const SizedBox(
                    height: 30,
                  ),
                  AboutListTile(
                    applicationName: "Lisans".tr(),
                    applicationIcon: Icon(Icons.file_open),
                    applicationVersion: "3.8",
                    child: Text("UygulamaHakkinda".tr(),
                        style: TextStyle(fontSize: 12)),
                    icon: Icon(Icons.info),
                    applicationLegalese: null,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future _cikisYap() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    await Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(builder: (context) => const SignInPage()),
        (route) => false);
  }

  _privateprofil() {
    //MyUser user = AuthService().user!;
    return Navigator.of(context)
        .push(CupertinoPageRoute(builder: (context) => const private_profil()));
    /* if (user.premium == true) {
      return Navigator.of(context).push(
          CupertinoPageRoute(builder: (context) => const private_profil()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.blue,
          content: Text("Premium üye olmayanlar bu alana erişemez",
              style: TextStyle(color: Colors.white))));
    } */
  }

/*   Widget control() {
    if (user.premium == true) {
      return IconButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.blue,
            content:
                Text("Premium üyesiniz", style: TextStyle(color: Colors.white)),
            duration: Duration(seconds: 1),
          ));
        },
        icon: const Icon(Icons.star),
        color: Colors.greenAccent,
      );
    } else {
      return IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.blue,
                content: Text("Premium üye olma kodları henüz yazılmadı",
                    style: TextStyle(color: Colors.white))));
          },
          icon: const Icon(Icons.star));
    }
  } */

  _imageController() {
    var whoData = AuthService().user;
    if (whoData!.image != null) {
      return NetworkImage(whoData.image!);
    } else {
      return AssetImage("images/logo.png");
    }
  }
}

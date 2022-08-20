// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../pages/gelen_kutusu.dart';
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
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
              accountName: Text(
                user.userName! + ' ' + user.soyisim!,
                style: const TextStyle(fontSize: 20),
              ),
              accountEmail: Text(user.email!),
              currentAccountPicture: _imageController()),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.person,
                  ),
                  title: const Text(
                    "PROFIL",
                    style: TextStyle(fontSize: 15),
                  ),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    _privateprofil();
                  },
                ),
                ListTile(
                    leading: const Icon(Icons.chat),
                    title:
                        const Text("MESAJLAR", style: TextStyle(fontSize: 15)),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => const Inbox()));
                    }),
                ListTile(
                    leading: const Icon(Icons.star),
                    title: const Text("PREMIUM DETAYLARI",
                        style: TextStyle(fontSize: 15)),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {}),
                ListTile(
                    leading: const Icon(Icons.safety_divider),
                    title: const Text("GÖRÜŞ - ÖNERİ BİLDİRİN",
                        style: TextStyle(fontSize: 12)),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {}),
                ListTile(
                    leading: const Icon(Icons.video_collection_outlined),
                    title: const Text("NASIL KULLANILIR ?",
                        style: TextStyle(fontSize: 12)),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {}),
                ListTile(
                    leading: const Icon(Icons.no_accounts),
                    title: const Text(
                      "ÇIKIŞ YAP",
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      _cikisYap();
                    }),
                const SizedBox(
                  height: 30,
                ),
                const AboutListTile(
                  applicationName: " LİSANS",
                  applicationIcon: Icon(Icons.file_open),
                  applicationVersion: "3.8",
                  child:
                      Text("UYGULAMA HAKKINDA", style: TextStyle(fontSize: 12)),
                  icon: Icon(Icons.info),
                  applicationLegalese: null,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future _cikisYap() async {
    FirebaseAuth.instance.signOut();
    await Navigator.of(context)
        .push(CupertinoPageRoute(builder: (context) => const SignInPage()));
  }

  _privateprofil() {
    MyUser user = AuthService().user!;
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

  Widget control() {
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
  }

  _imageController() {
    if (url != null) {
      return Image.network(url!);
    } else {
      return const Icon(Icons.no_photography);
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:version1/pages/bilgilerim.dart';
import 'package:version1/pages/profil.dart';
import 'package:version1/services/auth_service.dart';

class welcome extends StatefulWidget {
  const welcome({Key? key}) : super(key: key);

  @override
  State<welcome> createState() => _welcomeState();
}

var userControl = AuthService().user!;
var user = AuthService();

String? isim = AuthService().user!.userName;
String? ne = AuthService().user!.sex;
String? cinsiyet = ne == "Kadın" ? "Hanım" : "Bey";

class _welcomeState extends State<welcome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/background2.png"),
                    fit: BoxFit.cover)),
            child: Center(
              child: Column(
                children: [
                  Text("Merhaba ! Hoşgeldiniz $isim $cinsiyet "),
                  TextButton(onPressed: bilgilerimeGit, child: Text("Devam"))
                ],
              ),
            )),
      ),
    );
  }

  bilgilerimeGit() {
    setState(() {
      if (user.isHaveProfile) {
        Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(builder: (context) => bilgilerim()),
            ((route) => false));
        ;
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(builder: (context) => Profile()),
            ((route) => false));
      }
    });
  }
}

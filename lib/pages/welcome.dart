import 'package:easy_localization/easy_localization.dart';
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
var _user = AuthService();

String? isim = AuthService().user?.userName;
String? ne = AuthService().user?.sex;
String? cinsiyet = ne == "Female" ? "Hanim".tr() : "Bey".tr();

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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isim_deneme(),
                  TextButton(
                      onPressed: bilgilerimeGit, child: Text("WelcomeSayfaParterBulButon".tr()))
                ],
              ),
            )),
      ),
    );
  }

  Text isim_deneme() {
    if (_user.isHaveProfile) {
      return Text("WelcomeSayfaTekrarHosGeldiniz".tr()+" $isim $cinsiyet.");
    } else {
      return Text("WelcomeSayfaAramizdaGormek".tr());
    }
  }

  bilgilerimeGit() {
    setState(() {
      if (_user.isHaveProfile) {
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

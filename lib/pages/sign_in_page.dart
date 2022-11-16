// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:version1/pages/emailpassword.dart';
import 'package:version1/pages/profil.dart';
import 'package:version1/pages/welcome.dart';
import 'package:version1/services/auth_service.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

// ignore: duplicate_ignore
class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
    //******************************************************************//
    
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/background.png"), fit: BoxFit.cover)),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "OturumAcKaydol".tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              const SizedBox(height: 48),
              //******************************************************************//
              //GoogleGirisi(),
              //******************************************************************//
    
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: eMailGirisi(context),
              ),
    
              //AnonimGiris(),
              //******************************************************************//
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton eMailGirisi(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
            CupertinoPageRoute(builder: (context) => const EmailPassword()));
      },
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.email),
          Text(
            'EmailileOturum'.tr(),
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          Icon(Icons.email, color: Colors.white.withOpacity(0)),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  ElevatedButton GoogleGirisi() {
    return ElevatedButton(
        onPressed: _googleGirisi,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset("images/google-logo.png"),
            Text(
              'GoogleileOturum'.tr(),
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Image.asset(
              "images/google-logo.png",
              color: Colors.white.withOpacity(0),
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(primary: Colors.blue));
  }
//******************************************************************//

  // ignore: unused_element
  void _misafirGirisi() async {
    //UserCredential sonuc = await FirebaseAuth.instance.signInAnonymously();
    await Navigator.of(context)
        .push(CupertinoPageRoute(builder: (context) => const Profile()));
  }
//******************************************************************//

  _googleGirisi() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount? _googleUser = await _googleSignIn.signIn();
    if (_googleUser != null) {
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
      try {
        if (_googleAuth.idToken != null && _googleAuth.accessToken != null) {
          UserCredential sonuc = await FirebaseAuth.instance
              .signInWithCredential(GoogleAuthProvider.credential(
                  idToken: _googleAuth.idToken,
                  accessToken: _googleAuth.accessToken));
          User? _user = sonuc.user;

          if (_user != null) {
            await AuthService().checkUser();

            return Navigator.of(context).pushAndRemoveUntil(
                CupertinoPageRoute(builder: (context) => welcome()),
                ((route) => false));
          }
        }
      } on PlatformException catch (e) {
        Fluttertoast.showToast(
          msg: e.message.toString(),
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
        );
      }
    } else {
      return null;
    }
  }
}

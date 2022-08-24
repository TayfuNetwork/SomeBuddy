// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:version1/pages/emailpassword.dart';
import 'package:version1/pages/bilgilerim.dart';
import 'package:version1/pages/profil.dart';
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
    return Scaffold(
//******************************************************************//

      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/Logo.png"), fit: BoxFit.cover)),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /* ClipOval(
              child: Image.asset(
                "images/Logo.png",
                fit: BoxFit.cover,
              ),
            ), */

            const Text(
              "Oturum Açın / Kaydolun",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.white,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 48),
            //******************************************************************//
            GoogleGirisi(),
            //******************************************************************//

            eMailGirisi(context),

            //AnonimGiris(),
            //******************************************************************//
          ],
        ),
      ),
    );
  }

  RaisedButton eMailGirisi(BuildContext context) {
    return RaisedButton(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      onPressed: () {
        Navigator.of(context).push(
            CupertinoPageRoute(builder: (context) => const EmailPassword()));
      },
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.email),
          const Text(
            'Email ile oturum aç',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          Icon(Icons.email, color: Colors.white.withOpacity(0)),
        ],
      ),
      color: Colors.blue,
    );
  }

  //non_constant_identifier_names
  RaisedButton AnonimGiris() {
    return RaisedButton(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      onPressed: _misafirGirisi,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset("images/google-logo.png"),
          const Text(
            'anonim oturum test',
            style: TextStyle(color: Colors.black87),
          ),
          Image.asset(
            "images/google-logo.png",
            color: Colors.white.withOpacity(0),
          ),
        ],
      ),
      color: Colors.grey.shade300,
    );
  }

  // ignore: non_constant_identifier_names
  RaisedButton GoogleGirisi() {
    return RaisedButton(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      onPressed: _googleGirisi,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset("images/google-logo.png"),
          const Text(
            'Google ile oturum aç',
            style: TextStyle(color: Colors.black87, fontSize: 16),
          ),
          Image.asset(
            "images/google-logo.png",
            color: Colors.white.withOpacity(0),
          ),
        ],
      ),
      color: Colors.white,
    );
  }
//******************************************************************//

  void _misafirGirisi() async {
    UserCredential sonuc = await FirebaseAuth.instance.signInAnonymously();
    await Navigator.of(context)
        .push(CupertinoPageRoute(builder: (context) => const Profile()));
  }
//******************************************************************//

  _googleGirisi() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount? _googleUser = await _googleSignIn.signIn();
    if (_googleUser != null) {
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;

      if (_googleAuth.idToken != null && _googleAuth.accessToken != null) {
        UserCredential sonuc = await FirebaseAuth.instance.signInWithCredential(
            GoogleAuthProvider.credential(
                idToken: _googleAuth.idToken,
                accessToken: _googleAuth.accessToken));
        User? _user = sonuc.user;

        if (_user != null) {
          await AuthService().checkUser();

          if (AuthService().isHaveProfile) {
            return Navigator.of(context).pushAndRemoveUntil(
                CupertinoPageRoute(builder: (context) => const bilgilerim()),
                ((route) => false));
          } else {
            Navigator.pop(context);
            return Navigator.of(context).pushAndRemoveUntil(
                CupertinoPageRoute(builder: (context) => const Profile()),
                ((route) => false));
          }
        }
      }
    } else {
      return null;
    }
  }
}

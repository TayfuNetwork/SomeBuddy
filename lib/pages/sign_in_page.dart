// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:version1/models/user.dart';
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Hadi Başlayalım'),
        elevation: 0,
      ),
//******************************************************************//

      backgroundColor: Colors.grey.shade300,
      body: Container(
        color: const Color.fromARGB(255, 200, 207, 213),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Oturum Açın / Kaydolun",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  color: Colors.black),
            ),
            const SizedBox(height: 18),
            //******************************************************************//
            GoogleGirisi(),
            //******************************************************************//

            eMailGirisi(context),

            AnonimGiris(),
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
            'Email ve Şifre ile oturum aç',
            style: TextStyle(color: Colors.white),
          ),
          Icon(Icons.email, color: Colors.white.withOpacity(0)),
        ],
      ),
      color: Colors.purple,
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
          MyUser myUser = MyUser(userName: _user.displayName);
          AuthService().user = myUser;

          if (AuthService().isHaveProfile) {
            Navigator.pop(context);

            return Navigator.of(context).push(
                CupertinoPageRoute(builder: (context) => const bilgilerim()));
          } else {
            Navigator.pop(context);
            return Navigator.of(context).push(
                CupertinoPageRoute(builder: (context) => const Profile()));
          }
        }
      }
    } else {
      return null;
    }
  }
}

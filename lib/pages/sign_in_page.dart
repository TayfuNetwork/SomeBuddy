// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:line_icons/line_icons.dart';
import 'package:version1/control_pages/landing_page.dart';
import 'package:version1/pages/emailpassword.dart';
import 'package:version1/services/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

bool _isloading = false;

// ignore: duplicate_ignore
class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
       body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 220, 222, 238),
              Color.fromARGB(255, 76, 65, 147)
            ], end: Alignment.topRight, begin: Alignment.bottomRight),
            color: Color.fromARGB(255, 163, 215, 231),
           
          ),
           padding: const EdgeInsets.all(16.0),
          child: Container(
              child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "OturumAcKaydol".tr(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      fontStyle: FontStyle.italic, fontSize: 30),
                ),
                 const SizedBox(height: 48),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: _isloading ? null : _googleGirisi,
                      child: _isloading
                          ? buildSmallButton()
                          : Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(LineIcons.googlePlus),
                                Text(
                                  'GoogleileOturum'.tr(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                Image.asset(
                                  "images/google-logo.png",
                                  color: Colors.white.withOpacity(0),
                                ),
                              ],
                            ),
                      style: ElevatedButton.styleFrom(primary: Colors.blue)),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: eMailGirisi(context),
                ),
              ],
            ),
          )

            //AnonimGiris(),

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
        style: ElevatedButton.styleFrom(primary: Colors.blue));
  }

/*   void _misafirGirisi() async {
    UserCredential sonuc = await FirebaseAuth.instance.signInAnonymously();
    await Navigator.of(context)
        .push(CupertinoPageRoute(builder: (context) => const Profile()));
  } */

  _googleGirisi() async {
    setState(() {
      _isloading = true;
    });
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
          // ignore: unused_local_variable
          User? _user = await sonuc.user;
          try {
            await AuthService().checkUser();
            setState(() {
              _isloading = false;
            });
            return Navigator.of(context).pushAndRemoveUntil(
                CupertinoPageRoute(builder: (context) => LandingPage()),
                ((route) => false));
          } on Exception {
            setState(() {
              _isloading = true;
            });
            Fluttertoast.showToast(
              msg: "googlegiremedi".tr(),
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_LONG,
            );
            return Navigator.of(context).pushAndRemoveUntil(
                CupertinoPageRoute(builder: (context) => EmailPassword()),
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
      Fluttertoast.showToast(
        msg: "Transaction could not be completed",
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  buildSmallButton() {
    return Container(
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: Colors.blueAccent),
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }
}

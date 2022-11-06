// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:version1/control_pages/reset_password.dart';
import 'package:version1/pages/bilgilerim.dart';
import 'package:version1/pages/profil.dart';
import 'package:version1/services/auth_service.dart';

enum FormType { Register, Login }

// ignore: camel_case_types
class EmailPassword extends StatefulWidget {
  const EmailPassword({Key? key}) : super(key: key);

  @override
  State<EmailPassword> createState() => _EmailPasswordState();
}

// ignore: camel_case_types
class _EmailPasswordState extends State<EmailPassword> {
  String? _email, _sifre, _sifreTekrar;
  // ignore: unused_field
  String? _butonText, _linkText;
  var _formType = FormType.Login;
  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;

  _fromSubmit(BuildContext context) async {
    _formKey.currentState?.save();
    User? user;
    AuthService service = AuthService();

    if (_formType == FormType.Register) {
      if (_sifre != _sifreTekrar) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.blue,
            content: Text("EmailPassword".tr(),
                style: TextStyle(color: Colors.white))));
        return;
      }
      user = await service.signUp(_sifre!, _email!, context);

      if (user != null) {
        final fcmToken = await FirebaseMessaging.instance.getToken();
        FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .set({'token': fcmToken}, SetOptions(merge: true));
        AuthService().user!.token = fcmToken;
        Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(builder: (context) => const Profile()),
            (route) => false);
      }
    } if (_formType == FormType.Login)  {
      user = await service.signIn(_sifre!, _email!, context);
      if (user != null) {
        await AuthService().checkUser();

        Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(
                builder: (context) => AuthService().isHaveProfile
                    ? bilgilerim()
                    : const Profile()),
            ((route) => false));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _butonText = _formType == FormType.Login
        ? "EmailGirisYap".tr()
        : "EmailKayitOl".tr();
    Text _linkText =
        _formType == FormType.Register ? hesapVar() : HesabinizYokMu();

    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.png"), fit: BoxFit.cover)),
      child: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                /* Text("googleEmailDuo".tr(),
                    style: TextStyle(color: Colors.yellow),
                    textAlign: TextAlign.center), */
                Text("uyari".tr(),
                    style: TextStyle(color: Colors.yellow),
                    textAlign: TextAlign.center),
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Email',
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (String? girilenemail) {
                    _email = girilenemail;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.key),
                    hintText: 'Sifre'.tr(),
                    labelText: 'Sifre'.tr(),
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (String? girilensifre) {
                    _sifre = girilensifre;
                  },
                ),
                const SizedBox(height: 8),
                if (_formType == FormType.Login)
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) => ForgotPasswordPage())),
                    child: Text('SifreUnuttun'.tr()),
                  ),
                const SizedBox(height: 8),
                if (_formType == FormType.Register) ...[
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.key),
                      hintText: 'TekrarSifre'.tr(),
                      labelText: 'TekrarSifre'.tr(),
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (String? girilensifre) {
                      _sifreTekrar = girilensifre;
                    },
                  ),
                ],
                ElevatedButton(
                  onPressed: () => _fromSubmit(context),
                  child: Text(_butonText!),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => degistir(),
                  child: _linkText,
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Text hesapVar() {
    return Text(
      "ZatenHesapVar".tr(),
      style: TextStyle(color: Colors.yellow),
    );
  }

  Text HesabinizYokMu() {
    return Text(
      "HesabinizYokMu".tr(),
      style: TextStyle(color: Colors.yellow),
    );
  }

  degistir() {
    setState(() {
      _formType =
          _formType == FormType.Login ? FormType.Register : FormType.Login;
    });
  }
}

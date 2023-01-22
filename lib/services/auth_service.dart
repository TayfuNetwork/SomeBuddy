import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:version1/models/mesaj.dart';
import 'package:version1/models/user.dart';
import 'package:version1/services/notification.dart';

class AuthService {
  MyUser? user;

  bool isHaveProfile = false;

  static AuthService? _instance;

  factory AuthService() {
    if (_instance != null) {
      return _instance!;
    } else {
      _instance = AuthService._();
      return _instance!;
    }
  }

  AuthService._();

  FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> get userCollection =>
      FirebaseFirestore.instance.collection("Users");

  Future<User?> signUp(String sifre, String email, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: sifre);
      if (userCredential.user != null) {
        await checkUser();
        return userCredential.user;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("BilinmeyenHata".tr()),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("EmailZatenKullaniliyor".tr())));
      } else if (e.code == "weak-password") {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("SifreKisa".tr())));
      } else if (e.code == "invalid-email") {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("GecersizMail".tr())));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("BilinmeyenHata".tr()),
          ),
        );
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("return null hatası"),
      ),
    );
    return null;
  }

  Future<User?> signIn(String sifre, String email, BuildContext context) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(email: email, password: sifre);
      if (userCredential.user != null) {
        await checkUser();
        return userCredential.user;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("KayitliKullaniciYok".tr())));
      } else if (e.code == "wrong-password") {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("HataliSifer".tr())));
      } else if (e.code == "invalid-email") {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("GecersizMail".tr())));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("BilinmeyenHata".tr()),
          ),
        );
      }
    }
    return null;
  }

  Future checkUser() async {
    if (_auth.currentUser != null) {
      DocumentSnapshot<Map<String, dynamic>> doc =
          await userCollection.doc(_auth.currentUser!.uid).get();
      if (doc.data() != null) {
        try {
          MyUser user = MyUser.fromMap(doc.data()!);
          this.user = user;
          if (user.userName != null) {
            return isHaveProfile = true;
          }
          return;
        } on Exception catch (_) {}
      }
    }
    isHaveProfile = false;
  }

  Future<bool> updateUser(MyUser user) async {
    try {
      await userCollection
          .doc(user.id)
          .set(user.toMap(), SetOptions(merge: true));
      this.user = user;
      return true;
    } on Exception catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return false;
    }
  }

  Future<bool> updateOtherUser( String otherUserId, List<String> geriTakip) async {
    try {
      await userCollection.doc(otherUserId).update({"Geritakip":geriTakip});

      return true;
    } on Exception catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return false;
    }
  }

  Future<bool> updateUserName(String userID, String yeniUserName) async {
    if (yeniUserName.length < 0) {
      var _users = await FirebaseFirestore.instance
          .collection("Users")
          .where("userName", isEqualTo: yeniUserName)
          .get();
      if (_users.docs.isNotEmpty) {
        return false;
      } else {
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(userID)
            .update({"userName": yeniUserName});
        return true;
      }
    } else {
      Fluttertoast.showToast(
        msg: "ButunAlanlariEksiksiDoldur".tr(),
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return false;
    }
  }

  static saveMessage(Mesaj kaydedilecekMesaj) async {
    try {
      final x = DateTime.now().millisecondsSinceEpoch;

      var _mesajID = x.toString();

      var _myDocumentID =
          kaydedilecekMesaj.kimden + "--" + kaydedilecekMesaj.kime;
      var _receiverDocumentID =
          kaydedilecekMesaj.kime + "--" + kaydedilecekMesaj.kimden;
      var _kaydedilecekMesajYapisi = kaydedilecekMesaj.toMap();
      await FirebaseFirestore.instance
          .collection("konusmalar")
          .doc(_myDocumentID.toString())
          .collection("mesajlar")
          .doc(_mesajID.toString())
          .set(_kaydedilecekMesajYapisi);

      await FirebaseFirestore.instance
          .collection("konusmalar")
          .doc(_myDocumentID)
          .set({
        "konusma_sahibi": kaydedilecekMesaj.kimden,
        "kimle_konusuyor": kaydedilecekMesaj.kime,
        "son_yollanan_mesaj": kaydedilecekMesaj.mesaj,
        "sonMesajBenimMi": kaydedilecekMesaj.kimden,
        "olusturulma_tarihi": DateTime.now(),
        "goruldu": "true",
        "gorulduMu": "false"
      });

      _kaydedilecekMesajYapisi.update("bendenMi", (deger) => false);

      await FirebaseFirestore.instance
          .collection("konusmalar")
          .doc(_receiverDocumentID)
          .collection("mesajlar")
          .doc(_mesajID.toString())
          .set(_kaydedilecekMesajYapisi);

      await FirebaseFirestore.instance
          .collection("konusmalar")
          .doc(_receiverDocumentID)
          .set({
        "konusma_sahibi": kaydedilecekMesaj.kime,
        "kimle_konusuyor": kaydedilecekMesaj.kimden,
        "son_yollanan_mesaj": kaydedilecekMesaj.mesaj,
        "olusturulma_tarihi": DateTime.now(),
        "sonMesajBenimMi": kaydedilecekMesaj.kimden,
        "gorulduMu": "false",
        "goruldu": "false"
      });
      var _to = await FirebaseFirestore.instance
          .collection('Users')
          .doc(kaydedilecekMesaj.kime)
          .get();

      var userToken = _to.data()?['token'];

      await NotificationService().sendPushMessage(
          userToken, AuthService().user!.userName!, kaydedilecekMesaj.mesaj);
    } catch (e) {
      return false;
    }

    return true;
  }

  Future<bool> updateStatu(String userID, String newStatu) async {
    if (newStatu.length < 0) {
      var _users = await FirebaseFirestore.instance
          .collection("Users")
          .where("statu", isEqualTo: newStatu)
          .get();
      if (_users.docs.isNotEmpty) {
        return false;
      } else {
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(userID)
            .update({"statu": newStatu});
        return true;
      }
    } else {
      Fluttertoast.showToast(
        msg: "ButunAlanlariEksiksiDoldur".tr(),
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return false;
    }
  }
}

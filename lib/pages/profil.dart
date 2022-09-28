import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:version1/models/user.dart';
import 'package:version1/pages/bilgilerim.dart';
import 'package:version1/pages/sign_in_page.dart';
import 'package:version1/services/auth_service.dart';
import '../control_pages/json-models.dart';

// ignore: camel_case_types

class Profile extends StatefulWidget {
  const Profile({
    Key? key,
  }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

String? ad, soyad, yasi, cinsiyeti;

class _ProfileState extends State<Profile> {
  SexServices model1 = SexServices();
  int yas = 0;
  String? isim;
  String? soyisim;
  Sex? sex;
  String? bio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 9,
        automaticallyImplyLeading: false,
        title: Text('Profil'.tr()),
        actions: <Widget>[
          TextButton(
            onPressed: _cikisYap,
            child: Text(
              'CikisYap'.tr(),
              style: TextStyle(color: (Colors.red)),
            ),
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 10),
                Text('ProfilSayfaBilgilerDogrulugu'.tr(),
                    style: TextStyle(color: Colors.yellow)),
                const SizedBox(height: 10),

                TextField(
                  style: const TextStyle(color: Colors.white),
                  maxLength: 11,
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1)),
                    focusColor: Colors.blue,
                    hintText: 'Isim'.tr(),
                    enabled: true,
                  ),
                  autofocus: false,
                  onChanged: (girilenisim) {
                    isim = girilenisim;
                  },
                ),
                //******************************************************************//

                const SizedBox(height: 10),
                //******************************************************************//

                TextField(
                  maxLength: 11,
                  maxLines: 1,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1)),
                    focusColor: Colors.blue,
                    hintText: 'Soyisim'.tr(),
                    enabled: true,
                  ),
                  autofocus: false,
                  onChanged: (girilensoyad) {
                    soyisim = girilensoyad;
                  },
                ),
                //******************************************************************//

                const SizedBox(height: 10),
                //******************************************************************//

                TextField(
                    style: const TextStyle(color: Colors.white),
                    maxLength: 2,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1)),
                      focusColor: Colors.blue,
                      hintText: 'Yas'.tr(),
                    ),
                    autofocus: false,
                    onChanged: (deger) {
                      yas = int.tryParse(deger) ?? 0;
                    }),

                const SizedBox(height: 10),
                TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1)),
                      focusColor: Colors.blue,
                      hintText: 'Biografi'.tr(),
                    ),
                    autofocus: false,
                    onChanged: (deger) {
                      bio = deger;
                    }),

                const SizedBox(height: 10),
                //******************************************************************//
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Cinsiyet:".tr(),
                      style: TextStyle(color: Colors.blue),
                    ),
                    DropdownButton<int>(
                      iconEnabledColor: Colors.blue,
                      dropdownColor: const Color.fromARGB(255, 28, 185, 242),
                      style: const TextStyle(color: Colors.black),
                      value: sex?.x ?? 1000,
                      items: model1.sexs.map((a) {
                        return DropdownMenuItem(
                          child: Text(a.sex,
                              style: const TextStyle(color: Colors.white)),
                          value: a.x,
                          onTap: () {
                            setState(() {
                              sex = a;
                            });
                          },
                        );
                      }).toList(),
                      onChanged: (s) {},
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //******************************************************************//
                    if (isim != null &&
                        soyisim != null &&
                        sex != null &&
                        bio != null)
                      ElevatedButton(
                        // ignore: prefer_const_constructors

                        onPressed: () async {
                          setState(() {
                            ad = isim!;
                            soyad = soyisim!;
                            yasi = yas.toString();
                            cinsiyeti = (sex)!.sex;
                            bio = bio;
                          });
                          User user = FirebaseAuth.instance.currentUser!;

                          await user.updateDisplayName(
                            ad! + " " + soyad!,
                          );

                          MyUser myUser = MyUser(
                            email: user.email ?? "email",
                            userName: ad ?? "isimsiz",
                            id: user.uid,
                            yas: yas,
                            sex: (sex)!.sex,
                            bio: bio,
                            soyisim: soyisim,
                          );

                          AuthService().user = MyUser();
                          final fcmToken =
                              await FirebaseMessaging.instance.getToken();
                          FirebaseFirestore.instance
                              .collection('Users')
                              .doc(user.uid)
                              .set(
                                  {'token': fcmToken}, SetOptions(merge: true));

                          AuthService().user!.token = fcmToken;
                          await AuthService().updateUser(myUser);

                          myUser = MyUser(
                              email: user.email ?? "email",
                              userName: ad ?? "isimsiz",
                              id: user.uid,
                              yas: yas,
                              sex: (sex)!.sex,
                              bio: bio,
                              soyisim: soyisim,
                              token: fcmToken);
                          await AuthService().updateUser(myUser);
                          await Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) => bilgilerim()));
                          Navigator.of(context).pop();
                        },
                        child: Text('KaydetveDevamEt'.tr(),
                            style: TextStyle(color: Colors.white)),
                      ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
//******************************************************************//

  Future _cikisYap() async {
    FirebaseAuth.instance.signOut();
    await Navigator.of(context)
        .push(CupertinoPageRoute(builder: (context) => const SignInPage()));
  }
}

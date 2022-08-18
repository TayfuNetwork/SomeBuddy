import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:version1/models/user.dart';
import 'package:version1/pages/gelen_kutusu.dart';
import 'package:version1/pages/private_profil.dart';
import 'package:version1/pages/search_page.dart';
import 'package:version1/pages/sign_in_page.dart';
import 'package:version1/services/auth_service.dart';
import '../control_pages/json-models.dart';

// sadece oturum açmış kişiler bu sayfayı görebilir.
// ignore: camel_case_types

// ignore: camel_case_types
class bilgilerim extends StatefulWidget {
  const bilgilerim({
    Key? key,
  }) : super(key: key);

  @override
  _bilgilerimState createState() => _bilgilerimState();
}

String? ili, ilcesi, bransi, mevkisi;

// ignore: camel_case_types
class _bilgilerimState extends State<bilgilerim> {
  Brans? brans;
  String? mevki;
  BransServices model = BransServices();
  Il? il;
  String? ilce;
  IlService service = IlService();
  String? url = AuthService().user?.image;
  MyUser get user => AuthService().user!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
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
                      title: const Text("MESAJLAR",
                          style: TextStyle(fontSize: 15)),
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
                    child: Text("UYGULAMA HAKKINDA",
                        style: TextStyle(fontSize: 12)),
                    icon: Icon(Icons.info),
                    applicationLegalese: null,
                  )
                ],
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Bilgilerin'),
        actions: <Widget>[
          Row(
            children: [
              control(),
            ],
          )
        ],
      ),
//******************************************************************//
      body: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(color: Colors.grey, blurRadius: 6),
              ]),
//******************************************************************//

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
//******************************************************************//
              const Text('Kimliğiniz', style: TextStyle(color: Colors.grey)),
              ListTile(
                textColor: Colors.black,
                title: Text("${user.userName}"),
                leading: CircleAvatar(
                  child: Text(
                    "${user.yas}",
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  backgroundColor: Colors.blue,
                ),
                subtitle: const Text("ili, ilçesi, branşı, mevkisi"),
                trailing: const Icon(Icons.message),
                onTap: () {},
              ),
//******************************************************************//

              const SizedBox(height: 5),
              const Divider(
                thickness: 2,
                color: Colors.green,
              ),
              const SizedBox(height: 10),

//******************************************************************//

              const Text('Kayıt oluşturmadan da gezinebilirsiniz',
                  style: TextStyle(color: Colors.grey)),

              const SizedBox(height: 10),
//******************************************************************//

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "İl:",
                    style: TextStyle(color: Colors.blue),
                  ),
                  DropdownButton<int>(
                      menuMaxHeight: 300,
                      iconEnabledColor: Colors.blue,
                      dropdownColor: const Color.fromARGB(255, 28, 185, 242),
                      style: const TextStyle(color: Colors.black),
                      value: il?.plaka ?? 1,
                      items: service.iller.map((i) {
                        return DropdownMenuItem(
                          child: Text(i.il,
                              style: const TextStyle(color: Colors.black)),
                          value: i.plaka,
                          onTap: () {
                            setState(() {
                              il = i;
                              ilce = i.ilceleri.first;
                            });
                          },
                        );
                      }).toList(),
                      onChanged: (value) {}),
                ],
              ),
//******************************************************************//

              if (ilce != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text("ilçe:", style: TextStyle(color: Colors.blue)),
                    DropdownButton<String>(
                      menuMaxHeight: 400,
                      iconEnabledColor: Colors.blue,
                      dropdownColor: const Color.fromARGB(255, 28, 185, 242),
                      value: ilce ?? il!.ilceleri.first,
                      style: const TextStyle(color: Colors.black),
                      items: service.ilceler(il!.plaka).map((i) {
                        return DropdownMenuItem(
                          child: Text(
                            i,
                            style: const TextStyle(color: Colors.black),
                          ),
                          value: i,
                          onTap: () {
                            setState(() {
                              ilce = i;
                              ilce = ilce;
                            });
                          },
                        );
                      }).toList(),
                      onChanged: (s) {},
                    ),
                  ],
                ),
//******************************************************************//
              if (il != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text("Branş:", style: TextStyle(color: Colors.blue)),
                    DropdownButton<int>(
                      menuMaxHeight: 400,
                      iconEnabledColor: Colors.blue,
                      dropdownColor: const Color.fromARGB(255, 28, 185, 242),
                      style: const TextStyle(color: Colors.black),
                      value: brans?.no ?? 82,
                      items: model.branslar.map((b) {
                        return DropdownMenuItem(
                          child: Text(b.brans,
                              style: const TextStyle(color: Colors.black)),
                          value: b.no,
                          onTap: () {
                            setState(() {
                              brans = b;
                              mevki = b.mevki.first;
                            });
                          },
                        );
                      }).toList(),
                      onChanged: (s) {},
                    ),
                  ],
                ),
//******************************************************************//

              if (mevki != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text("mevki:", style: TextStyle(color: Colors.blue)),
                    DropdownButton<String>(
                      menuMaxHeight: 400,
                      iconEnabledColor: Colors.blue,
                      dropdownColor: const Color.fromARGB(255, 28, 185, 242),
                      value: mevki ?? brans!.mevki.first,
                      style: const TextStyle(color: Colors.black),
                      items: model.mevki(brans!.no).map((b) {
                        return DropdownMenuItem(
                          child: Text(
                            b,
                            style: const TextStyle(color: Colors.black),
                          ),
                          value: b,
                          onTap: () {
                            setState(() {
                              mevki = b;
                            });
                          },
                        );
                      }).toList(),
                      onChanged: (s) {},
                    ),
                  ],
                ),
//******************************************************************//

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () async {
                        var _user = AuthService().user;
                        if (_user!.il != null) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              backgroundColor: Colors.blue,
                              duration: Duration(seconds: 5),
                              content: Text(
                                  "Kaydınız silindi, artık arama sonuçlarında görünmezsiniz. Keşfedilmek için bilgilerinizi doldurunuz.",
                                  style: TextStyle(color: Colors.white))));
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  backgroundColor: Colors.blue,
                                  duration: Duration(seconds: 5),
                                  content: Text(
                                    "Bir kaydınız bulunmuyor!",
                                    style: TextStyle(color: Colors.white),
                                  )));
                        }
                        var userID = AuthService().user!.id;
                        return FirebaseFirestore.instance
                            .collection("Users")
                            .doc(userID)
                            .update({
                          'il': null,
                          'ilce': null,
                          'brans': null,
                          'mevki': null
                        });
                      },
                      child: const Text(
                        'Hobi kaydımı sil',
                        style: TextStyle(color: Colors.pink),
                        softWrap: true,
                      )),
                  if (ilce != null && brans != null)
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            ili = (il)!.il;
                            ilcesi = ilce;
                            bransi = (brans)!.brans;
                            mevkisi = mevki;
                            MyUser user = AuthService().user!;
                            user = user.copyWith(
                              brans: bransi,
                              il: ili,
                              ilce: ilce,
                              mevki: mevki,
                            );
                            await AuthService().updateUser(user);
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (context) => const searchPage()));
                          },
                          child: const Text('Kaydet ve partner bul'),
                        ),
                      ],
                    ),

//******************************************************************//
                  if (ilce == null || brans == null)
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) => const searchPage()));
                        },
                        child: const Text('Gezinti')),
                ],
              ),
            ],
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

  _privateprofil() {
    MyUser user = AuthService().user!;
    if (user.premium == true) {
      return Navigator.of(context).push(
          CupertinoPageRoute(builder: (context) => const private_profil()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.blue,
          content: Text("Premium üye olmayanlar bu alana erişemez",
              style: TextStyle(color: Colors.white))));
    }
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

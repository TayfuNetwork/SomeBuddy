import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:version1/control_pages/myDrawer.dart';
import 'package:version1/models/user.dart';
import 'package:version1/pages/search_page.dart';
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
Color? ppColor;

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
  bool? x = AuthService().user?.premium;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        elevation: 8,
        title: Center(child: const Text('Ana Sayfa')),
        actions: <Widget>[control()],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/Logo.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('Kimlik',
                          style: TextStyle(color: Colors.grey)),
                      ListTile(
                        textColor: Colors.black,
                        title: Text("${user.userName}"),
                        leading: CircleAvatar(
                          child: Text(
                            "${user.yas}",
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                          backgroundColor: renk(),
                        ),
                        subtitle: const Text("il, ilçe, branş, mevki"),
                        trailing: const Icon(Icons.message),
                        onTap: () {},
                      ),
                      const SizedBox(height: 5),
                      const Divider(
                        thickness: 2,
                        color: Colors.green,
                      ),
                      const SizedBox(height: 10),
                      const Text('Kayıt oluşturmadan da gezinebilirsiniz',
                          style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 10),
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
                              dropdownColor:
                                  const Color.fromARGB(255, 28, 185, 242),
                              style: const TextStyle(color: Colors.black),
                              value: il?.plaka ?? 1,
                              items: service.iller.map((i) {
                                return DropdownMenuItem(
                                  child: Text(i.il,
                                      style:
                                          const TextStyle(color: Colors.black)),
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
                      if (ilce != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text("ilçe:",
                                style: TextStyle(color: Colors.blue)),
                            DropdownButton<String>(
                              menuMaxHeight: 400,
                              iconEnabledColor: Colors.blue,
                              dropdownColor:
                                  const Color.fromARGB(255, 28, 185, 242),
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
                      if (il != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text("Branş:",
                                style: TextStyle(color: Colors.blue)),
                            DropdownButton<int>(
                              menuMaxHeight: 400,
                              iconEnabledColor: Colors.blue,
                              dropdownColor:
                                  const Color.fromARGB(255, 28, 185, 242),
                              style: const TextStyle(color: Colors.black),
                              value: brans?.no ?? 82,
                              items: model.branslar.map((b) {
                                return DropdownMenuItem(
                                  child: Text(b.brans,
                                      style:
                                          const TextStyle(color: Colors.black)),
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
                      if (mevki != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text("mevki:",
                                style: TextStyle(color: Colors.blue)),
                            DropdownButton<String>(
                              menuMaxHeight: 400,
                              iconEnabledColor: Colors.blue,
                              dropdownColor:
                                  const Color.fromARGB(255, 28, 185, 242),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if (AuthService().user!.il != null)
                            TextButton(
                                onPressed: () async {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          backgroundColor: Colors.blue,
                                          duration: Duration(seconds: 5),
                                          content: Text(
                                              "Kaydınız silindi, artık arama sonuçlarında görünmezsiniz. Keşfedilmek için bilgilerinizi doldurunuz.",
                                              style: TextStyle(
                                                  color: Colors.white))));

                                  var userID = AuthService().user!.id;
                                  try {
                                    await FirebaseFirestore.instance
                                        .collection("Users")
                                        .doc(userID)
                                        .update({
                                      'il': null,
                                      'ilce': null,
                                      'brans': null,
                                      'mevki': null
                                    });
                                    AuthService().user =
                                        AuthService().user!.copyWith(
                                              il: null,
                                              ilce: null,
                                              brans: null,
                                              mevki: null,
                                            );
                                    setState(() {});
                                  } on Exception {}
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

                                    Navigator.of(context).push(
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                const searchPage()));
                                  },
                                  child: const Text('Kaydet ve partner bul'),
                                ),
                              ],
                            ),
                          if (ilce == null || brans == null)
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(CupertinoPageRoute(
                                      builder: (context) =>
                                          const searchPage()));
                                },
                                child: const Text('Gezinti')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
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

  Color renk() {
    if (AuthService().user!.sex == 'Kadın') {
      return ppColor = Colors.pink.shade400;
    } else {
      return ppColor = Colors.blue;
    }
  }
}

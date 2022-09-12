import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:version1/control_pages/json-models.dart';
import 'package:flutter/material.dart';
import 'package:version1/control_pages/myDrawer.dart';
import 'package:version1/pages/bilgilerim.dart';
import 'package:version1/pages/gelen_kutusu.dart';
import 'package:version1/pages/results.dart';
import 'package:version1/services/auth_service.dart';

// ignore: camel_case_types
class searchPage extends StatefulWidget {
  const searchPage({
    Key? key,
  }) : super(key: key);

  @override
  _searchPageState createState() => _searchPageState();
}

// ignore: camel_case_types
class _searchPageState extends State<searchPage> {
  Brans? brans;
  String? mevki;
  BransServices model = BransServices();
  String? il;
  String? ilce;
  String? bulunanAd;
  String? bulunanSoyad;
  String? bulunanYas;
  String? bulunanIl;
  String? bulunanIlce;
  String? bulunanBrans;
  String? bulunanMevki;
  Future<void> arama() async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Results(
          il: il!,
          ilce: ilce!,
          brans: brans!.brans,
          mevki: mevki!,
          ppColor: Colors.blue,
          sIcon: const Icon(Icons.photo),
        ),
      ),
    );
    setState(() {
      sonAramaSakla();
    });
  }

  Future<void> yakinArama() async {
    var user = AuthService().user!;

    bulunanIl = (user.il);
    bulunanIlce = user.ilce!;
    bulunanBrans = user.brans!;
    bulunanMevki = user.mevki!;
    ppColor = Colors.blue;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Results(
          il: bulunanIl!,
          ilce: bulunanIlce!,
          brans: bulunanBrans!,
          mevki: bulunanMevki!,
          ppColor: Colors.blue,
          sIcon: const Icon(Icons.photo),
        ),
      ),
    );
    print("${(user.il)},${(user.ilce)},${(user.brans)}, ${(user.mevki)}");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          flexibleSpace: Container(),
          backgroundColor: Colors.blueAccent,
          elevation: 10,
          toolbarHeight: 80,
          toolbarOpacity: 0.8,
          shadowColor: Colors.black,
          title: const Text(
            "Gezinti",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(8))),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
          actions: [
            IconButton(
                onPressed: _mesajlaraGit,
                icon: const Icon(
                  Icons.chat,
                  color: Colors.white,
                )),
            IconButton(
              icon: const Icon(Icons.home, color: Colors.white),
              onPressed: _bilgilerimeGit,
            ),
          ],
        ),
        //******************************************************************//

        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image:
                  AssetImage("images/background.png"), // <-- BACKGROUND IMAGE
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
            //******************************************************************//

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "! Yazım yanlışına dikkat ediniz !",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                const SizedBox(height: 20),
                //******************************************************************//

                TextFormField(
                  inputFormatters: <TextInputFormatter>[
                    UpperCaseTextFormatter()
                  ],
                  maxLines: 1,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1)),
                    focusColor: Colors.blue,
                    hintText: 'İli giriniz',
                    enabled: true,
                  ),
                  autofocus: false,
                  onChanged: (girilenil) {
                    il = girilenil;
                  },
                ),
                //******************************************************************//

                const SizedBox(height: 10),
                //******************************************************************//

                TextField(
                  inputFormatters: <TextInputFormatter>[
                    UpperCaseTextFormatter()
                  ],
                  textCapitalization: TextCapitalization.words,
                  maxLines: 1,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1)),
                    focusColor: Colors.blue,
                    hintText: 'İlçeyi giriniz',
                    enabled: true,
                  ),
                  autofocus: false,
                  onChanged: (girilenilce) {
                    ilce = girilenilce;
                  },
                ),

                //******************************************************************//

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Icon(
                      Icons.download,
                      color: Colors.blue,
                    )
                  ],
                ),
                //******************************************************************//

                if (brans != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("mevki:",
                          style: TextStyle(color: Colors.blue)),
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
                      Icon(
                        Icons.download,
                        color: Colors.blue,
                      )
                    ],
                  ),
                //******************************************************************//

                Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (il != null && ilce != null && brans != null) {
                            arama();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: Colors.blue,
                                    content: Text(
                                        "Bütün alanları eksiksiz doldurmalısınız.",
                                        style:
                                            TextStyle(color: Colors.white))));
                          }
                        },
                        child: const Text('Ara')),
                    SizedBox(
                      height: 30,
                    ),
                    if (AuthService().user?.il != null)
                      Row(
                        children: [
                          Icon(Icons.navigate_next, color: Colors.red),
                          TextButton(
                              onPressed: () {
                                yakinArama();
                              },
                              child: Text(" En yakın partneri bul")),
                        ],
                      ),
                    Row(
                      children: [
                        Icon(Icons.navigate_next, color: Colors.red),
                        TextButton(
                            onPressed: sonAramaTekrar,
                            child: Text("Bir önceki aramayı tekrarla")),
                      ],
                    )
                  ],
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }

  _mesajlaraGit() {
    return Navigator.of(context)
        .push(CupertinoPageRoute(builder: (context) => const Inbox()));
  }

  _bilgilerimeGit() {
    return Navigator.of(context)
        .push(CupertinoPageRoute(builder: (context) =>  bilgilerim()));
  }

  Future<void> sonAramaSakla() async {
    final preferences = await SharedPreferences.getInstance();

    preferences.setString("sonIl", il!);
    preferences.setString("sonIlce", ilce!);
    preferences.setString("sonBrans", brans!.brans);
    preferences.setString("sonMevki", mevki!);
  }

  Future<void> sonAramaTekrar() async {
    final preferences = await SharedPreferences.getInstance();

    bulunanIl = preferences.get("sonIl").toString();
    bulunanIlce = preferences.get("sonIlce").toString();
    bulunanBrans = preferences.get("sonBrans").toString();
    bulunanMevki = preferences.get("sonMevki").toString();
    setState(() {});

    await Navigator.of(context).push(CupertinoPageRoute(
        builder: (context) => Results(
              il: bulunanIl!,
              ilce: bulunanIlce!,
              brans: bulunanBrans!,
              mevki: bulunanMevki!,
              ppColor: Colors.blue,
              sIcon: Icon(Icons.person),
            )));

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.blue,
        content: Text("Üzgünüz, son arama kaydınıza ulaşamadık!",
            style: TextStyle(color: Colors.white))));
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: capitalize(newValue.text),
      selection: newValue.selection,
    );
  }
}

String capitalize(String value) {
  if (value.trim().isEmpty) return "";
  return "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}";
}

import 'package:flutter/cupertino.dart';
import 'package:version1/control_pages/json-models.dart';
import 'package:flutter/material.dart';
import 'package:version1/control_pages/myDrawer.dart';
import 'package:version1/pages/bilgilerim.dart';
import 'package:version1/pages/gelen_kutusu.dart';
import 'package:version1/pages/results.dart';
import '../control_pages/json-models.dart';

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
  Il? il;
  String? ilce;
  IlService service = IlService();
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
          il: il!.il,
          ilce: ilce!,
          brans: brans!.brans,
          mevki: mevki!,
          ppColor: Colors.blue,
          sIcon: const Icon(Icons.photo),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: const Text('Arama Yap'),
        actions: [
          IconButton(
            icon: const Icon(Icons.chat),
            onPressed: _mesajlaraGit,
          ),
        ],
      ),
//******************************************************************//

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/Logo.png"), // <-- BACKGROUND IMAGE
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
              const Text('Partner bulmanın en kolay yolu',
                  style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 20),
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
                  ElevatedButton(
                      onPressed: () {
                        if (il != null && ilce != null && brans != null) {
                          arama();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  backgroundColor: Colors.blue,
                                  content: Text(
                                      "Bütün açılır menüleri doldurmalısınız",
                                      style: TextStyle(color: Colors.white))));
                        }
                      },
                      child: const Text('Ara')),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const bilgilerim()));
                      },
                      child: const Text('Bilgilerin')),
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }

  _mesajlaraGit() {
    return Navigator.of(context)
        .push(CupertinoPageRoute(builder: (context) => const Inbox()));
  }
}

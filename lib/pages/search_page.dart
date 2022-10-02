import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:version1/control_pages/json-models.dart';
import 'package:flutter/material.dart';
import 'package:version1/control_pages/myDrawer.dart';
import 'package:version1/control_pages/badge_goster.dart';
import 'package:version1/pages/bilgilerim.dart';
import 'package:version1/pages/result_Sex.dart';
import 'package:version1/pages/results.dart';
import 'package:version1/services/ad_helper.dart';
import 'package:version1/services/auth_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

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
  String? Cinsiyet;
  String? secilenCinsiyet;
  bool? izlendi = false;
  Future<void> cinsiyetArama() async {
    if (adHelper.rewardedAd != null) {
      await adHelper.showRewardedAd((p1) => izlendi = true);
    }
  }

  Future<void> arama() async {
    if (adHelper.interstitialAd != null) {
      await adHelper.showInterstitialAd(
        (p0) {
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
        },
      );
    }

    setState(() {
      sonAramaSakla();
    });
  }

  Future<void> yakinArama() async {
    if (adHelper.interstitialAd != null) {
      await adHelper.showInterstitialAd(
        (p0) {
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
        },
      );
    }
  }

  String? sex;
  SexServices model1 = SexServices();
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
          title: Text(
            "AnaSayfaGezintiButonu".tr(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(8))),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
          actions: [
            baddge(),
            IconButton(
              icon: const Icon(Icons.home, color: Colors.white),
              onPressed: _bilgilerimeGit,
            ),
          ],
        ),
        //******************************************************************//

        body: SingleChildScrollView(
          child: Container(
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
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "YazimYanlisiDikkat".tr(),
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
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1)),
                      focusColor: Colors.blue,
                      hintText: 'IliGiriniz'.tr(),
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
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1)),
                      focusColor: Colors.blue,
                      hintText: 'IlceGiriniz'.tr(),
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
                      Text("Brans:".tr(), style: TextStyle(color: Colors.blue)),
                      DropdownButton<int>(
                        menuMaxHeight: 400,
                        iconEnabledColor: Colors.blue,
                        dropdownColor: const Color.fromARGB(255, 28, 185, 242),
                        style: const TextStyle(color: Colors.black),
                        value: brans?.no ?? 82,
                        items: model.branslar.map((b) {
                          return DropdownMenuItem(
                            child: Text(b.brans.tr(),
                                style: TextStyle(color: Colors.black)),
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
                        Text("Mevki:".tr(),
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
                                b.tr(),
                                style: TextStyle(color: Colors.black),
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
                        ),
                      ],
                    ),
                  //******************************************************************//
                  if (izlendi == true)
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    secilenCinsiyet = "Male";
                                    sex = secilenCinsiyet;
                                  });
                                },
                                child: Text(
                                  "Male",
                                  style: TextStyle(color: Colors.black),
                                )),
                            if (secilenCinsiyet == "Male")
                              Icon(
                                Icons.download_done_outlined,
                                color: Colors.green,
                              )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    secilenCinsiyet = "Female";
                                    sex = secilenCinsiyet;
                                  });
                                },
                                child: Text(
                                  "Female",
                                  style: TextStyle(color: Colors.black),
                                )),
                            if (secilenCinsiyet == "Female")
                              Icon(
                                Icons.download_done_outlined,
                                color: Colors.green,
                              )
                          ],
                        )
                      ],
                    ),
                  Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (il != null && ilce != null && brans != null) {
                              if (izlendi == true) {
                                Navigator.of(context).push(CupertinoPageRoute(
                                    builder: (context) => Results2(
                                        sex: sex!,
                                        sIcon: Icon(Icons.person),
                                        ppColor: ppColor!,
                                        brans: brans!.brans,
                                        il: il!,
                                        ilce: ilce!,
                                        mevki: mevki!)));
                              } else {
                                arama();
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.blue,
                                      content: Text(
                                          "ButunAlanlariEksiksiDoldur".tr(),
                                          style:
                                              TextStyle(color: Colors.white))));
                            }
                          },
                          child: Text('Ara'.tr())),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.navigate_next,
                              color: Colors.red,
                            ),
                            Text(
                              "CinsiyetFiltrele".tr(),
                              style: TextStyle(color: Colors.red),
                            ),
                            Icon(
                              Icons.navigate_next,
                              color: Colors.red,
                            ),
                            TextButton(
                                onPressed: () {
                                  cinsiyetArama();
                                  setState(() {
                                    izlendi = true;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    "Izle".tr(),
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if (AuthService().user?.il != null)
                        Row(
                          children: [
                            Icon(Icons.navigate_next, color: Colors.red),
                            TextButton(
                                onPressed: () {
                                  yakinArama();
                                },
                                child: Text("EnYakinPartner".tr())),
                          ],
                        ),
                      Row(
                        children: [
                          Icon(Icons.navigate_next, color: Colors.red),
                          TextButton(
                              onPressed: sonAramaTekrar,
                              child: Text("BirOncekiAramaTekrar".tr())),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: AdSize.banner.width.toDouble(),
                        height: AdSize.banner.height.toDouble(),
                        alignment: Alignment.bottomCenter,
                        child: AdWidget(
                          ad: adHelper.createBannerAd(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }

  _bilgilerimeGit() {
    return Navigator.of(context)
        .push(CupertinoPageRoute(builder: (context) => bilgilerim()));
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

    if (preferences.get("sonIl") != null) {
      await Navigator.of(context).push(CupertinoPageRoute(
          builder: (context) => Results(
                il: bulunanIl!,
                ilce: bulunanIlce!,
                brans: bulunanBrans!,
                mevki: bulunanMevki!,
                ppColor: Colors.blue,
                sIcon: Icon(Icons.person),
              )));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.blue,
          content: Text("SonAramaKaydiUok".tr(),
              style: TextStyle(color: Colors.white))));
    }
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

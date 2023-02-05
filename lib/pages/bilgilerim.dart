import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:version1/control_pages/myDrawer.dart';
import 'package:version1/models/user.dart';
import 'package:version1/control_pages/badge_goster.dart';
import 'package:version1/pages/search_page.dart';
import 'package:version1/pages/show.dart';
import 'package:version1/services/auth_service.dart';
import '../control_pages/json-models.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// sadece oturum açmış kişiler bu sayfayı görebilir.
// ignore: camel_case_types
// ignore: camel_case_types
class bilgilerim extends StatefulWidget {
  bilgilerim({
    Key? key,
  }) : super(key: key);

  @override
  _bilgilerimState createState() => _bilgilerimState();
}

var status = Permission.location.status;
Future<bool> isShown = Permission.contacts.shouldShowRequestRationale;
String? ili, ilcesi, bransi, mevkisi;
Color? ppColor;
late BannerAd _bottomBannerAd;
bool _isBottomAdLoaded = false;

// ignore: camel_case_types
class _bilgilerimState extends State<bilgilerim> {
  late TextEditingController _bioController;
  Brans? brans;
  String? mevki;
  BransServices model = BransServices();
  String? il;
  String? ilce;
  String? url = AuthService().user?.image;
  MyUser get user => AuthService().user!;
  //bool? premiumMu = AuthService().user?.premium;
  Position? _currentPosition;
  String? _konumIl;
  String? _konumIlce = "Place";
  bool _isloading = true;
  String _durum = "AnaSayfaKayitOlusturButonu".tr();
  bool? _hobidas = false;
  final takipciler = getTakipciler(AuthService().user!.id!);

  //final fcmToken = AuthService().user!.token;

  late var a;

  fcmGetir() async {
    await FirebaseMessaging.instance.getToken().then((value) {
      if (value != null) {
        a = value.toString();
      }
    });

    AuthService().user!.token = a;
    FirebaseFirestore.instance
        .collection("Users")
        .doc(AuthService().user!.id)
        .update({'token': a});
  }

  @override
  void initState() {
    _bioController = TextEditingController();
    fcmGetir();
    bannercrate();
    super.initState();
    isShown;
  }

  @override
  void dispose() {
    super.dispose();
    _bioController.dispose();
    _bottomBannerAd.dispose();
  }

  bannercrate() {
    _bottomBannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId:
          'ca-app-pub-1753932827820630/5568784899', //'ca-app-pub-3940256099942544/6300978111',
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isBottomAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, e) {
          ad.dispose();
        },
      ),
      request: AdRequest(),
    );
    _bottomBannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent,
          onPressed: () {
            statuCreate();
          },
          child: Icon(LineIcons.pen),
          foregroundColor: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        drawer: MyDrawer(),
        appBar: AppBar(
          toolbarHeight: 70,
          elevation: 0,
          backgroundColor: Colors.blueAccent,
          title: Center(
            child: Text(
              "AnaSayfaAppBarTittle".tr(),
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
            ),
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
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: _searchPage,
            ),
            //controlPremium()
          ],
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 220, 222, 238),
                              Color.fromARGB(255, 76, 65, 147)
                            ],
                            end: Alignment.topRight,
                            begin: Alignment.bottomRight),
                        color: Color.fromARGB(255, 163, 215, 231)
                        /* image: DecorationImage(
                  image: AssetImage("images/background.png"),
                  fit: BoxFit.cover) */
                        ),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
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
                            Text("AnaSayfaKimlik".tr(),
                                style: TextStyle(color: Colors.grey)),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20))),
                              color: Color.fromARGB(221, 23, 22, 22),
                              child: ListTile(
                                title: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      SingleChildScrollView(
                                        child: Text(
                                          "${AuthService().user!.userName} ${AuthService().user!.soyisim} - ",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "${AuthService().user!.ilce} / ${AuthService().user!.mevki}",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.yellow),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                leading: CircleAvatar(
                                  child: Text(
                                    AuthService().user!.yas.toString(),
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  backgroundColor: previewColor(),
                                ),
                                subtitle: SingleChildScrollView(
                                  child: Text(
                                    "${AuthService().user!.bio}",
                                    style: const TextStyle(color: Colors.blue),
                                  ),
                                ),
                                trailing: previewIcon(),
                                onTap: () {},
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "${("Takipte").tr()}: ${(benimHobidas().toString())} ",
                                  style: TextStyle(color: Colors.blue),
                                ),
                                Text(
                                    "${("Takip Eden").tr()} : ${benOnlarinHobidas().toString()} ",
                                    style: TextStyle(color: Colors.blue)),
                              ],
                            ),
                            const SizedBox(height: 5),
                            if (AuthService().user!.il != null)
                              TextButton(
                                  onPressed: () async {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor: Colors.blue,
                                            duration: Duration(seconds: 5),
                                            content: Text(
                                                'KaydinizSilindi'.tr(),
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
                                  child: Text(
                                    'AnaSayfaHobiKatiniSil'.tr(),
                                    style: TextStyle(color: Colors.pink),
                                    softWrap: true,
                                  )),
                            const Divider(
                              thickness: 2,
                              color: Colors.blueAccent,
                            ),
                            const SizedBox(height: 10),
                            Text('AnaSayfaKonumAciklama'.tr(),
                                style: TextStyle(color: Colors.grey)),
                            const SizedBox(height: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                    onPressed: () async {
                                      LocationPermission permission;
                                      permission =
                                          await Geolocator.checkPermission();
                                      if (permission ==
                                          LocationPermission.denied) {
                                        showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (builder) =>
                                                Stack(children: [
                                                  AlertDialog(
                                                    content: Card(
                                                      child: Text(
                                                          "konumaIzinver".tr()),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          TextButton(
                                                            onPressed:
                                                                () async {
                                                              Navigator.pop(
                                                                  context);
                                                              try {
                                                                _currentPosition =
                                                                    await determinePosition();
                                                                await _getAddressFromLatLng();
                                                                _getCurrentLocation();
                                                                il = _konumIl;
                                                                ilce =
                                                                    _konumIlce;

                                                                setState(() {
                                                                  _isloading =
                                                                      false;
                                                                });
                                                                await Future.delayed(
                                                                    Duration(
                                                                        seconds:
                                                                            3));
                                                                setState(() {
                                                                  _getCurrentLocation();
                                                                  il = _konumIl;
                                                                  ilce =
                                                                      _konumIlce;
                                                                  _isloading =
                                                                      true;
                                                                  _durum =
                                                                      "AnaSayfaKonumBelirlendiButonu"
                                                                          .tr();
                                                                });
                                                                await Future.delayed(
                                                                    Duration(
                                                                        seconds:
                                                                            3));
                                                                setState(() {
                                                                  _durum =
                                                                      "AnaSayfaTekrarTaratButonu"
                                                                          .tr();
                                                                });
                                                              } catch (e) {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        SnackBar(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .blue,
                                                                  content: Text(
                                                                      "AnaSayfaKonumErisilemiyorHata"
                                                                          .tr(),
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white)),
                                                                  duration:
                                                                      Duration(
                                                                          seconds:
                                                                              5),
                                                                ));
                                                              }
                                                            },
                                                            child:
                                                                Text("İzinVer")
                                                                    .tr(),
                                                          ),
                                                          TextButton(
                                                            onPressed:
                                                                () async {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text(
                                                                    "İzinVerme")
                                                                .tr(),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                ]));
                                      } else {
                                        try {
                                          _currentPosition =
                                              await determinePosition();
                                          await _getAddressFromLatLng();
                                          _getCurrentLocation();
                                          il = _konumIl;
                                          ilce = _konumIlce;

                                          setState(() {
                                            _isloading = false;
                                          });
                                          await Future.delayed(
                                              Duration(seconds: 3));
                                          setState(() {
                                            _getCurrentLocation();
                                            il = _konumIl;
                                            ilce = _konumIlce;
                                            _isloading = true;
                                            _durum =
                                                "AnaSayfaKonumBelirlendiButonu"
                                                    .tr();
                                          });
                                          await Future.delayed(
                                              Duration(seconds: 3));
                                          setState(() {
                                            _durum = "AnaSayfaTekrarTaratButonu"
                                                .tr();
                                          });
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            backgroundColor: Colors.blue,
                                            content: Text(
                                                "AnaSayfaKonumErisilemiyorHata"
                                                    .tr(),
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            duration: Duration(seconds: 5),
                                          ));
                                        }
                                      }
                                    },
                                    child: !_isloading
                                        ? buildSmallButton()
                                        : Text(_durum)),
                                if (il != null) info()
                              ],
                            ),
                            if (il != null)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text("Brans".tr(),
                                        style: TextStyle(color: Colors.blue)),
                                    DropdownButton<int>(
                                      menuMaxHeight: 400,
                                      iconEnabledColor: Colors.blue,
                                      dropdownColor: const Color.fromARGB(
                                          255, 28, 185, 242),
                                      style:
                                          const TextStyle(color: Colors.black),
                                      value: brans?.no ?? 82,
                                      items: model.branslar.map((b) {
                                        return DropdownMenuItem(
                                          child: Text(b.brans,
                                              style: const TextStyle(
                                                  color: Colors.black)),
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
                              ),
                            if (mevki != null)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                          b,
                                          style: const TextStyle(
                                              color: Colors.black),
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
                                    Icons.abc,
                                    color: Colors.white.withOpacity(0),
                                  )
                                ],
                              ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                if (ilce != null && brans != null)
                                  Column(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () async {
                                          ili = (il)!;
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
                                          var dateTime = DateTime.now();
                                          var ddd =
                                              DateFormat('MM/dd/yyyy HH:mm')
                                                  .format(dateTime);
                                          await FirebaseMessaging.instance
                                              .getToken();
                                          FirebaseFirestore.instance
                                              .collection('Users')
                                              .doc(user.id)
                                              .set({'date': ddd},
                                                  SetOptions(merge: true));
                                          await AuthService().updateUser(user);
                                          Navigator.of(context).push(
                                              CupertinoPageRoute(
                                                  builder: (context) =>
                                                      const searchPage()));
                                        },
                                        child: Text(
                                            'AnaSayfaKaydetvePartnerBulButonu'
                                                .tr()),
                                      ),
                                    ],
                                  ),
                                if (ilce == null || brans == null)
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            CupertinoPageRoute(
                                                builder: (context) =>
                                                    const searchPage()));
                                      },
                                      child:
                                          Text('AnaSayfaGezintiButonu'.tr())),
                                SizedBox(
                                  height: 20,
                                ),
                                Divider(
                                  thickness: 2,
                                  color: Colors.blueAccent,
                                ),
                                TextButton(
                                    onPressed: () {
                                      if (_hobidas == false) {
                                        _hobidas = true;
                                        setState(() {
                                          _hobidas = true;
                                        });
                                      } else {
                                        _hobidas = false;
                                        setState(() {
                                          _hobidas = false;
                                        });
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Center(
                                            child: Text("Hobidaşların".tr())),
                                        budiesIcon(),
                                      ],
                                    )),
                                StreamBuilder(
                                    stream: takipciler,
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      if (!snapshot.hasData) {
                                        return Text("Hiç hobidaşınız yok".tr(),
                                            style:
                                                TextStyle(color: Colors.black));
                                      }
                                      if (snapshot.data.data() != null) {
                                        MyUser user = MyUser.fromMap(
                                            snapshot.data.data()!);
                                        if (_hobidas != false) {
                                          return SizedBox(
                                            //height: 190,
                                            child: Wrap(
                                                spacing: 8,
                                                runSpacing: 8,
                                                children: (user.takip!
                                                      ..sort((a, b) =>
                                                          a.compareTo(b)))
                                                    .map((u) {
                                                  return FutureBuilder<
                                                          DocumentSnapshot<
                                                              Map<String,
                                                                  dynamic>>>(
                                                      future: getUser(u),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          if (snapshot.data!
                                                                  .data() !=
                                                              null) {
                                                            MyUser izlenen =
                                                                MyUser.fromMap(
                                                                    snapshot
                                                                        .data!
                                                                        .data()!);
                                                            ImageProvider
                                                                _havePhoto() {
                                                              if (izlenen
                                                                      .image !=
                                                                  null) {
                                                                return NetworkImage(
                                                                  izlenen
                                                                      .image!,
                                                                );
                                                              } else {
                                                                return const AssetImage(
                                                                    "images/logo.png");
                                                              }
                                                            }

                                                            Text
                                                                ControlHobby() {
                                                              if (izlenen.il !=
                                                                  null) {
                                                                return Text(
                                                                  "${izlenen.il}/${izlenen.ilce} - ${(izlenen.brans)!.tr()}/${(izlenen.mevki)!.tr()}",
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .yellow),
                                                                );
                                                              } else {
                                                                return Text(
                                                                  "HobiKaydiBulunmuyor"
                                                                      .tr(),
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .orange),
                                                                );
                                                              }
                                                            }

                                                            _moveBox() async {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder: (builder) => Stack(
                                                                    fit: StackFit
                                                                        .expand,
                                                                    children: [
                                                                      AlertDialog(
                                                                        backgroundColor:
                                                                            Colors.white,
                                                                        content:
                                                                            Container(
                                                                          width:
                                                                              400,
                                                                          height:
                                                                              400,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            image:
                                                                                DecorationImage(image: _havePhoto(), fit: BoxFit.fill),
                                                                            color:
                                                                                Colors.blue,
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(12)),
                                                                          ),
                                                                        ),
                                                                        actions: [
                                                                          Center(
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: ControlHobby(),
                                                                                ),
                                                                                Text(
                                                                                  izlenen.bio!,
                                                                                  style: TextStyle(color: Colors.black),
                                                                                ),
                                                                                TextButton(
                                                                                    onPressed: () {
                                                                                      Navigator.of(context).push(CupertinoPageRoute(
                                                                                          builder: (context) => show(
                                                                                                whoData: izlenen,
                                                                                              )));
                                                                                    },
                                                                                    child: Text("Profil".tr()))
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ]),
                                                              );
                                                            }

                                                            return Column(
                                                              children: [
                                                                GestureDetector(
                                                                  onTap:
                                                                      _moveBox,
                                                                  child:
                                                                      Container(
                                                                    width: 60,
                                                                    height: 60,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      image: DecorationImage(
                                                                          image:
                                                                              _havePhoto(),
                                                                          fit: BoxFit
                                                                              .fill),
                                                                      color: Colors
                                                                          .blue,
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(30) //                 <--- border radius here
                                                                              ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  izlenen
                                                                      .userName!,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                )
                                                              ],
                                                            );
                                                          }
                                                        }
                                                        return CircularProgressIndicator();
                                                      });
                                                }).toList()),
                                          );
                                        } else {
                                          return SizedBox();
                                        }
                                      } else {
                                        return Text(
                                          "Hiç hobidaşınız yok".tr(),
                                          style: TextStyle(color: Colors.black),
                                        );
                                      }
                                    }),
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
            _isBottomAdLoaded
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: _bottomBannerAd.size.width.toDouble(),
                      height: _bottomBannerAd.size.height.toDouble(),
                      child: AdWidget(
                        ad: _bottomBannerAd,
                      ),
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }

  Dialog? statuCreate() {
    showDialog(
      context: context,
      builder: (builder) => Stack(fit: StackFit.expand, children: [
        AlertDialog(
          title: Center(
            child: Text(
              "Nedüşünüyorsun".tr(),
              style: TextStyle(color: Colors.blue, fontSize: 14),
            ),
          ),
          backgroundColor: Colors.white,
          content: Container(
            height: 100,
            width: 600,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 220, 222, 238),
                  Color.fromARGB(255, 76, 65, 147)
                ], end: Alignment.topRight, begin: Alignment.bottomRight),
                color: Color.fromARGB(255, 163, 215, 231)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 2,
                  controller: _bioController,
                  readOnly: false,
                  decoration: InputDecoration(
                      labelText: 'Paylaşım'.tr(),
                      hintText: 'BioOrnek'.tr(),
                      border: OutlineInputBorder()),
                ),
              ),
            ),
          ),
          actions: [
            Center(
              child: Column(
                children: [
                  TextButton(
                      onPressed: () async {
                        final _userModel = AuthService();
                        var userID = AuthService().user!.id;
                        await FirebaseFirestore.instance
                            .collection("Users")
                            .doc(userID)
                            .update({'bio': _bioController.text});

                        _userModel.user!.bio =
                            _bioController.text; //auth servisdeki user
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.blue,
                            content: Text("BiografiDegisBasarili".tr(),
                                style: TextStyle(color: Colors.white))));
                      },
                      child:
                          Text("Gönder".tr(), style: TextStyle(fontSize: 18)))
                ],
              ),
            ),
          ],
        ),
      ]),
    );
    return null;
  }

  Column info() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Il".tr(),
                style: TextStyle(color: Colors.blue),
              ),
              Text(
                "$il ",
                style: TextStyle(color: Colors.black),
              ),
              Icon(
                Icons.navigate_before,
                color: Colors.blue,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Ilce".tr(),
                style: TextStyle(color: Colors.blue),
              ),
              Text(
                "$ilce",
                style: TextStyle(color: Colors.black),
              ),
              Icon(
                Icons.navigate_before,
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /*  Widget controlPremium() {
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
        icon: const Icon(Icons.privacy_tip_sharp),
        color: Colors.orange,
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
  } */
  Color renk() {
    if (AuthService().user!.sex == 'Female' ||
        AuthService().user!.sex == 'Kadın') {
      return ppColor = Colors.pink.shade400;
    } else {
      return ppColor = Colors.blueAccent;
    }
  }

  Future _getCurrentLocation() async {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) async {
      _currentPosition = position;
      await _getAddressFromLatLng();
    }).catchError((e) {});
  }

  Future<void> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    _currentPosition = position;
    _getAddressFromLatLng();
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    return position;
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);
      Placemark place = placemarks[0];
      if (place.subAdministrativeArea!.length > 1) {
        _konumIl = "${place.administrativeArea}";
        _konumIlce = "${place.subAdministrativeArea}";
      } else {
        _konumIl = " ${place.administrativeArea}";
        _konumIlce = "${place.locality}";
      }
    } catch (e) {}
  }

  Text ControlName() {
    if (user.il != null) {
      return Text(
        "${user.il}/${user.ilce} - ${user.brans}/${user.mevki}",
        style: const TextStyle(
          color: Colors.blue,
        ),
      );
    } else {
      return Text(
        "HobiKaydiBulunmuyor.".tr(),
        style: const TextStyle(color: Colors.orange),
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

  _searchPage() {
    return Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(builder: (context) => const searchPage()),
        ((route) => false));
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUser(String u) {
    return FirebaseFirestore.instance.collection("Users").doc(u).get();
  }

  /*  _previewPhoto() {
    if (AuthService().user!.image != null) {
      return NetworkImage(AuthService().user!.image!);
    } else {
      return const AssetImage("images/logo.png");
    }
  } */

  Icon previewIcon() {
    if (AuthService().user!.sex == 'Female' ||
        AuthService().user!.sex == 'Female') {
      return Icon(
        Icons.person,
        color: Colors.pink,
      );
    } else {
      return Icon(
        Icons.person,
        color: Colors.blue,
      );
    }
  }

  Color previewColor() {
    if (AuthService().user!.sex == 'Female' ||
        AuthService().user!.sex == 'Female') {
      return Colors.pink;
    } else {
      return Colors.blue;
    }
  }

  benimHobidas() {
    List? a = AuthService().user!.takip;
    if (AuthService().user!.takip != null) {
      return a!.length;
    } else {
      return 0;
    }
  }

  benOnlarinHobidas() {
    List? takipte = AuthService().user!.geriTakip;
    if (takipte != null) {
      return takipte.length;
    } else {
      return 0;
    }
  }

  Icon budiesIcon() {
    if (_hobidas == false) {
      return Icon(LineIcons.doorClosed);
    } else {
      return Icon(LineIcons.doorOpen);
    }
  }
}

Stream getTakipciler(String currentUserID) {
  return FirebaseFirestore.instance
      .collection("Users")
      .doc(currentUserID)
      .snapshots(includeMetadataChanges: false);
}

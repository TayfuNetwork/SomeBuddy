import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:version1/control_pages/myDrawer.dart';
import 'package:version1/models/user.dart';
import 'package:version1/pages/search_page.dart';
import 'package:version1/services/auth_service.dart';
import '../control_pages/json-models.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'gelen_kutusu.dart';

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

var status = Permission.location.status;
Future<bool> isShown = Permission.contacts.shouldShowRequestRationale;
String? ili, ilcesi, bransi, mevkisi;
Color? ppColor;

// ignore: camel_case_types
class _bilgilerimState extends State<bilgilerim> {
  Brans? brans;
  String? mevki;
  BransServices model = BransServices();
  String? il;
  String? ilce;
  IlService service = IlService();
  String? url = AuthService().user?.image;
  MyUser get user => AuthService().user!;
  bool? x = AuthService().user?.premium;
  Position? _currentPosition;
  String? _konumIl;
  String? _konumIlce;
  bool _isloading = true;
  String _durum = "Konum Oluştur";
  @override
  void initState() {
    super.initState();
    isShown;
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
            "Ana Sayfa",
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
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: _searchPage,
            ),
            controlPremium()
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/background.png"),
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
                          subtitle: ControlName(),
                          trailing: const Icon(Icons.message),
                          onTap: () {},
                        ),
                        const SizedBox(height: 5),
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
                                'Kaydı Sil !',
                                style: TextStyle(color: Colors.pink),
                                softWrap: true,
                              )),
                        const Divider(
                          thickness: 2,
                          color: Colors.blueAccent,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                            'Konum oluşturarak kaydınızı başlatabilirsiniz',
                            style: TextStyle(color: Colors.grey)),
                        const SizedBox(height: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                                onPressed: () async {
                                  _currentPosition = await determinePosition();
                                  await _getAddressFromLatLng();
                                  _getCurrentLocation();
                                  il = _konumIl;
                                  ilce = _konumIlce;

                                  setState(() {});
                                  setState(() {
                                    _isloading = false;
                                  });
                                  await Future.delayed(Duration(seconds: 5));
                                  setState(() {
                                    _getCurrentLocation();
                                    il = _konumIl;
                                    ilce = _konumIlce;
                                    _isloading = true;
                                    _durum = "Konum Belirlendi";
                                  });
                                  await Future.delayed(Duration(seconds: 3));
                                  setState(() {
                                    _durum = "Konum Oluştur";
                                  });
                                },
                                child: !_isloading
                                    ? buildSmallButton()
                                    : Text(_durum)),
                            if (il != null) info()
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
                                      style:
                                          const TextStyle(color: Colors.black),
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
                                    Navigator.of(context).push(
                                        CupertinoPageRoute(
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
      ),
    );
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
                "il :",
                style: TextStyle(color: Colors.blue),
              ),
              Text(
                "$il ",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "ilce :",
                style: TextStyle(color: Colors.blue),
              ),
              Text(
                "$ilce",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget controlPremium() {
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
  }

  Color renk() {
    if (AuthService().user!.sex == 'Kadın') {
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
      print(position);

      _currentPosition = position;
      await _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
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
    } catch (e) {
      print(e);
    }
  }

  Text ControlName() {
    if (user.il != null) {
      return Text(
        "${user.il}/${user.ilce} - ${user.brans}/${user.mevki}",
        style: const TextStyle(color: Colors.blue),
      );
    } else {
      return Text(
        "Hobi kaydı bulunmuyor.",
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

  _mesajlaraGit() {
    return Navigator.of(context)
        .push(CupertinoPageRoute(builder: (context) => const Inbox()));
  }

  _searchPage() {
    return Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(builder: (context) => const searchPage()),
        ((route) => false));
  }
}

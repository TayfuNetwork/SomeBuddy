// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:version1/control_pages/myDrawer.dart';
import 'package:version1/models/medya.dart';
import 'package:version1/models/user.dart';
import 'package:version1/control_pages/badge_goster.dart';
import 'package:version1/pages/bilgilerim.dart';
import 'package:version1/pages/search_page.dart';
import 'package:version1/services/auth_service.dart';

// ignore: camel_case_types
class private_profil extends StatefulWidget {
  const private_profil({Key? key}) : super(key: key);

  @override
  State<private_profil> createState() => _private_profilState();
}

// ignore: camel_case_types
class _private_profilState extends State<private_profil> {
  late TextEditingController _userNameController;
  late TextEditingController _bioController;
  late TextEditingController _statuController;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _bioController = TextEditingController();
    _statuController = TextEditingController();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _bioController.dispose();
    _statuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _userModel = AuthService().user;
    _userNameController.text = (_userModel!.userName).toString();
    final _bio = AuthService().user!.bio;
    _bioController.text = _bio.toString();
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(LineIcons.pen),
          foregroundColor: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        drawer: MyDrawer(),
        appBar: AppBar(
          toolbarHeight: 70,
          elevation: 0,
          backgroundColor: Colors.blueAccent,
          title: Center(
            child: Text(
              "PrivateProfilAppbarTitle".tr(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
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
            IconButton(
              icon: const Icon(Icons.home, color: Colors.white),
              onPressed: _bilgilerimeGit,
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 220, 222, 238),
                Color.fromARGB(255, 76, 65, 147)
              ], end: Alignment.topRight, begin: Alignment.bottomRight),
              color: Color.fromARGB(255, 163, 215, 231)
              /* image: DecorationImage(
                  image: AssetImage("images/background.png"),
                  fit: BoxFit.cover) */
              ),
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 160,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      leading: const Icon(Icons.camera),
                                      title: Text("KameradanCek".tr()),
                                      onTap: () {
                                        uploadProfilPhoto(ImageSource.camera);
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.image),
                                      title: Text("Galeriden".tr()),
                                      onTap: () {
                                        uploadProfilPhoto(ImageSource.gallery);
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.no_accounts),
                                      title: Text("FotoKaldir".tr()),
                                      onTap: () {
                                        deleteProfilPhoto();
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child:
                        StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      stream: galeri(),
                      builder: (a, snapshot) {
                        if (snapshot.hasData) {
                          MyUser pphoto =
                              MyUser.fromMap(snapshot.data!.data()!);
                          if (pphoto.image != null) {
                            return CircleAvatar(
                              backgroundImage: NetworkImage(pphoto.image!),
                              radius: 75,
                              backgroundColor: Colors.white,
                            );
                          } else {
                            return const CircleAvatar(
                                backgroundImage: AssetImage("images/logo.png"),
                                radius: 75);
                          }
                        } else {
                          return const CircleAvatar(
                              backgroundImage: AssetImage("images/logo.png"),
                              radius: 75);
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    enabled: false,
                    initialValue: _userModel.email,
                    readOnly: true,
                    decoration: InputDecoration(
                        labelText: 'Email'.tr(),
                        hintText: 'Email'.tr(),
                        border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLength: 13,
                    maxLines: 1,
                    controller: _userNameController,
                    //initialValue: _userModel.user!.userName,
                    readOnly: false,
                    decoration: InputDecoration(
                        labelText: 'KullaniciAdi'.tr(),
                        hintText: 'KullaniciAdi'.tr(),
                        border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLines: 2,
                    controller: _bioController,
                    //initialValue: _userModel.user!.userName,
                    readOnly: false,
                    decoration: InputDecoration(
                        labelText: 'Paylaşım'.tr(),
                        hintText: 'BioOrnek'.tr(),
                        border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        _savetheChanges(context);
                      },
                      child: Text('DegisiklikKaydet'.tr())),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () {
                            uploadGalleryPhotoCamera(ImageSource.camera);
                          },
                          child: Text(
                            'KameradanCek'.tr(),
                            style: TextStyle(color: Colors.black),
                          )),
                      TextButton(
                          onPressed: () {
                            uploadGalleryPhotoCamera(ImageSource.gallery);
                          },
                          child: Text('Galeriden'.tr(),
                              style: TextStyle(color: Colors.black))),
                    ],
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(color: Colors.grey, blurRadius: 6),
                      ]),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: StreamBuilder<
                              DocumentSnapshot<Map<String, dynamic>>>(
                          stream: galeri(),
                          builder: (c, snap) {
                            if (snap.hasData) {
                              MyUser user = MyUser.fromMap(snap.data!.data()!);
                              List<Medya> photos = user.gPic ?? [];

                              return SingleChildScrollView(
                                  child: Row(
                                children: photos.map((e) {
                                  return GestureDetector(
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(e.url),
                                      radius: 75,
                                      backgroundColor: Colors.white,
                                    ),
                                    onTap: () {
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (builder) => Stack(children: [
                                          AlertDialog(
                                            content: Card(
                                              child: Image.network(e.url),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                            ),
                                            actions: <Widget>[
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  TextButton(
                                                    onPressed: () async {
                                                      var kisi = AuthService()
                                                          .user!
                                                          .id;
                                                      await FirebaseFirestore
                                                          .instance
                                                          .doc('Users/$kisi')
                                                          .set(
                                                              {'image': e.url},
                                                              SetOptions(
                                                                  merge: true));
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                        "ProfilResmiYap".tr()),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      var userID = AuthService()
                                                          .user!
                                                          .id;
                                                      var _secilenResim =
                                                          FirebaseStorage
                                                              .instance
                                                              .ref(
                                                                  'Users/gallery/${e.ref}');
                                                      // ignore: unnecessary_null_comparison
                                                      if (_secilenResim !=
                                                          null) {
                                                        _secilenResim.delete();
                                                        setState(() {
                                                          galeri();
                                                        });
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection("Users")
                                                            .doc(userID)
                                                            .update({
                                                          'gPic': FieldValue
                                                              .arrayRemove(
                                                                  [e.toMap()])
                                                        });
                                                        Navigator.pop(context);
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(SnackBar(
                                                                backgroundColor:
                                                                    Colors.blue,
                                                                content: Text(
                                                                    "KayitliResimYok"
                                                                        .tr(),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white))));
                                                      }
                                                    },
                                                    child:
                                                        Text("ResmiSil".tr()),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Positioned(
                                            child: Card(
                                              elevation: 10,
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(35.0),
                                              ),
                                              child: ClipOval(
                                                child: Material(
                                                  color: Colors
                                                      .transparent, // button color
                                                  child: InkWell(
                                                    splashColor: Colors
                                                        .red, // inkwell color
                                                    child: const SizedBox(
                                                      width: 35,
                                                      height: 35,
                                                      child: Icon(
                                                        Icons.close,
                                                        color: Colors.black,
                                                        size: 19,
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            top: 150,
                                            right: 20,
                                          )
                                        ]),
                                      );
                                    },
                                  );
                                }).toList(),
                              ));
                            } else {
                              return Container();
                            }
                          })),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }

  void _savetheChanges(BuildContext context) async {
    final _userModel = AuthService();
    if (_userModel.user!.userName != _userNameController.text) {
      var updateResult = await _userModel.updateUserName(
          (_userModel.user!.id).toString(), _userNameController.text);
      if (updateResult == true) {
        _userModel.user!.userName = _userNameController.text;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.blue,
            content: Text("KullaniciAdDegistirmeBasarili".tr(),
                style: TextStyle(color: Colors.white))));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.blue,
            content: Text("BuKullaniciAdiAlindi".tr(),
                style: TextStyle(color: Colors.white))));
      }
    }
    var userID = AuthService().user!.id;

    FirebaseFirestore.instance
        .collection("Users")
        .doc(userID)
        .collection('image');
    if (_userModel.user!.bio != _bioController.text) {
      await FirebaseFirestore.instance //bu firebasedeki için
          .collection("Users")
          .doc(userID)
          .update({'bio': _bioController.text});

      _userModel.user!.bio = _bioController.text; //auth servisdeki user
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.blue,
          content: Text("BiografiDegisBasarili".tr(),
              style: TextStyle(color: Colors.white))));
    }
  }

  deleteProfilPhoto() async {
    var userID = AuthService().user!.id;
    var adres = FirebaseFirestore.instance
        .collection("Users")
        .doc(userID)
        .collection('image');

    FirebaseFirestore.instance
        .collection("Users")
        .doc(userID)
        .update({'image': null});
    // ignore: unnecessary_null_comparison
    if (adres == null) {
      var _profileRef =
          FirebaseStorage.instance.ref('Users/profile_photos/photo_$userID');
      _profileRef.delete();
    }
    // ignore: unnecessary_null_comparison
    adres == null
        ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.blue,
            content: Text("KayitliBirResimBulunmuyo".tr(),
                style: TextStyle(color: Colors.white))))
        : "";
  }

  image() {
    var _profilFoto = AuthService().user!.image;

    if (_profilFoto == null) {
      return const AssetImage("images/google-logo.png");
    } else {
      return NetworkImage(_profilFoto);
    }
  }

  uploadGalleryPhotoCamera(ImageSource sourche) async {
    final ImagePicker _picker = ImagePicker();

    var userID = AuthService().user!.id;

    XFile? _file = await _picker.pickImage(source: sourche, imageQuality: 40);

    String ref = 'photo_$userID' +
        '_' +
        DateTime.now().millisecondsSinceEpoch.toString();
    var _profileRef = await FirebaseStorage.instance.ref('Users/gallery/$ref');
    if (_file != null) {
      var _task = _profileRef.putFile(File(_file.path));
      _task.whenComplete(() async {
        var _url = await _profileRef.getDownloadURL();
        Medya medya = Medya(url: _url, ref: ref);
        var kisi = AuthService().user!.id;
        await FirebaseFirestore.instance.doc('Users/$kisi').set({
          'gPic': FieldValue.arrayUnion([medya.toMap()])
        }, SetOptions(merge: true));
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.blue,
          content: Text("YuklemeIslemiIptal".tr(),
              style: TextStyle(color: Colors.white))));
    }
  }

  uploadProfilPhoto(ImageSource sourche) async {
    final ImagePicker _picker = ImagePicker();
    var userID = AuthService().user!.id;
    XFile? _file = await _picker.pickImage(source: sourche, imageQuality: 40);
    String ref = 'photo_$userID' +
        '_' +
        DateTime.now().millisecondsSinceEpoch.toString();
    var _profileRef =
        await FirebaseStorage.instance.ref('Users/profil_photos/$ref');
    if (_file != null) {
      var _task = _profileRef.putFile(File(_file.path)); // bak null check
      _task.whenComplete(() async {
        var _url = await _profileRef.getDownloadURL();
        //Medya medya = Medya(url: _url, ref: ref);
        var kisi = AuthService().user!.id;
        await FirebaseFirestore.instance
            .doc('Users/$kisi')
            .set({'image': _url}, SetOptions(merge: true));
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.blue,
          content: Text("Yuklemeİslemiİptal".tr(),
              style: TextStyle(color: Colors.white))));
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> galeri() {
    var userID = AuthService().user!.id;
    var galerinstance =
        FirebaseFirestore.instance.collection('Users').doc(userID).snapshots();
    return galerinstance;
  }

  _bilgilerimeGit() {
    return Navigator.of(context)
        .push(CupertinoPageRoute(builder: (context) => bilgilerim()));
  }

  _searchPage() {
    return Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(builder: (context) => const searchPage()),
        ((route) => false));
  }
}

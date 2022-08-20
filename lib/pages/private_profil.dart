import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:version1/control_pages/myDrawer.dart';
import 'package:version1/models/medya.dart';
import 'package:version1/models/user.dart';
import 'package:version1/pages/bilgilerim.dart';
import 'package:version1/services/auth_service.dart';

import 'gelen_kutusu.dart';

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

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _bioController = TextEditingController();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _userModel = AuthService().user;
    _userNameController.text = (_userModel!.userName).toString();
    final _bio = AuthService().user!.bio;
    _bioController.text = _bio.toString();
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: const Text('Size Özel'),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: _bilgilerimeGit,
          ),
        ],
      ),
      body: SingleChildScrollView(
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
                                  title: const Text("Kameradan Çek"),
                                  onTap: () {
                                    uploadProfilPhoto(ImageSource.camera);
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.image),
                                  title: const Text("Galeriden Seç"),
                                  onTap: () {
                                    uploadProfilPhoto(ImageSource.gallery);
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.no_accounts),
                                  title: const Text("Fotoğrafı Kaldır"),
                                  onTap: () {
                                    deleteProfilPhoto();
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: galeri(),
                  builder: (a, snapshot) {
                    if (snapshot.hasData) {
                      MyUser pphoto = MyUser.fromMap(snapshot.data!.data()!);
                      if (pphoto.image != null) {
                        return CircleAvatar(
                          backgroundImage: NetworkImage(pphoto.image!),
                          radius: 75,
                          backgroundColor: Colors.white,
                        );
                      } else {
                        return const CircleAvatar(
                            backgroundImage: AssetImage("images/top.jpg"),
                            radius: 75);
                      }
                    } else {
                      return const CircleAvatar(
                          backgroundImage: AssetImage("images/top.jpg"),
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
                decoration: const InputDecoration(
                    labelText: 'Emailiniz',
                    hintText: 'Email',
                    border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _userNameController,
                //initialValue: _userModel.user!.userName,
                readOnly: false,
                decoration: const InputDecoration(
                    labelText: 'Kullanıcı Adınız',
                    hintText: 'Kullanıcı Adı',
                    border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _bioController,
                //initialValue: _userModel.user!.userName,
                readOnly: false,
                decoration: const InputDecoration(
                    labelText: 'Biografi',
                    hintText:
                        'Örn: Satranç oynamak için de iletişime geçebilirsiniz..',
                    border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    _savetheChanges(context);
                  },
                  child: const Text('Değişiklikleri Kaydet')),
            ),
            const Text(
              'Kimim ?',
              style: TextStyle(color: Colors.grey),
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
                      child: const Text(
                        'Kameradan resim ekle',
                      )),
                  TextButton(
                      onPressed: () {
                        uploadGalleryPhotoCamera(ImageSource.gallery);
                      },
                      child: const Text('Galerinden resim ekle')),
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
                  child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              FlatButton(
                                                onPressed: () async {
                                                  var kisi =
                                                      AuthService().user!.id;
                                                  await FirebaseFirestore
                                                      .instance
                                                      .doc('Users/$kisi')
                                                      .set({
                                                    'image': e.url
                                                  }, SetOptions(merge: true));
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                    "Profil resmi yap"),
                                              ),
                                              FlatButton(
                                                onPressed: () async {
                                                  var userID =
                                                      AuthService().user!.id;
                                                  var _secilenResim =
                                                      FirebaseStorage.instance.ref(
                                                          'Users/gallery/${e.ref}');
                                                  if (_secilenResim != null) {
                                                    _secilenResim.delete();

                                                    var yol = FirebaseFirestore
                                                        .instance
                                                        .collection("Users")
                                                        .doc(userID)
                                                        .collection('gPic');

                                                    Navigator.pop(context);
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(const SnackBar(
                                                            backgroundColor:
                                                                Colors.blue,
                                                            content: Text(
                                                                "Kayıtlı bir resim bulunmuyor",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white))));
                                                  }
                                                },
                                                child: const Text("Resmi Sil"),
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
                                                splashColor:
                                                    Colors.red, // inkwell color
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
      )),
    );
  }

  void _savetheChanges(BuildContext context) async {
    final _userModel = AuthService();
    if (_userModel.user!.userName != _userNameController.text) {
      var updateResult = await _userModel.updateUserName(
          (_userModel.user!.id).toString(), _userNameController.text);
      if (updateResult == true) {
        _userModel.user!.userName = _userNameController.text;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.blue,
            content: Text("Kullanıcı adı değştirme işlemi başarılı",
                style: TextStyle(color: Colors.white))));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.blue,
            content: Text("Bu kullanıcı adı daha önce alınmış!",
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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.blue,
          content: Text("Biografi değştirme işlemi başarılı",
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
    if (adres == null) {
      var _profileRef =
          FirebaseStorage.instance.ref('Users/profile_photos/photo_$userID');
      _profileRef.delete();
    }
    adres == null
        ? ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.blue,
            content: Text("Kayıtlı bir resim bulunmuyor",
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
    XFile? _file = await _picker.pickImage(source: sourche);
    String ref = 'photo_$userID' +
        '_' +
        DateTime.now().millisecondsSinceEpoch.toString();
    var _profileRef = await FirebaseStorage.instance.ref('Users/gallery/$ref');
    if (_file != null) {
      var _task = _profileRef.putFile(File(_file.path)); // bak null check
      _task.whenComplete(() async {
        var _url = await _profileRef.getDownloadURL();
        Medya medya = Medya(url: _url, ref: ref);
        var kisi = AuthService().user!.id;
        await FirebaseFirestore.instance.doc('Users/$kisi').set({
          'gPic': FieldValue.arrayUnion([medya.toMap()])
        }, SetOptions(merge: true));
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.blue,
          content: Text("Yükleme işlemi iptal edildi",
              style: TextStyle(color: Colors.white))));
    }
  }

  uploadProfilPhoto(ImageSource sourche) async {
    final ImagePicker _picker = ImagePicker();
    var userID = AuthService().user!.id;
    XFile? _file = await _picker.pickImage(source: sourche);
    String ref = 'photo_$userID' +
        '_' +
        DateTime.now().millisecondsSinceEpoch.toString();
    var _profileRef =
        await FirebaseStorage.instance.ref('Users/profil_photos/$ref');
    if (_file != null) {
      var _task = _profileRef.putFile(File(_file.path)); // bak null check
      _task.whenComplete(() async {
        var _url = await _profileRef.getDownloadURL();
        Medya medya = Medya(url: _url, ref: ref);
        var kisi = AuthService().user!.id;
        await FirebaseFirestore.instance
            .doc('Users/$kisi')
            .set({'image': _url}, SetOptions(merge: true));
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.blue,
          content: Text("Yükleme işlemi iptal edildi",
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
        .push(CupertinoPageRoute(builder: (context) => const bilgilerim()));
  }
}

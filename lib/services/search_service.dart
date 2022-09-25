import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:version1/models/user.dart';

import '../models/konusma.dart';
import 'auth_service.dart';

class SearchService {
  bool isHaveProfile = false;

  static SearchService? _instance;

  factory SearchService() {
    if (_instance != null) {
      return _instance!;
    } else {
      _instance = SearchService._();
      return _instance!;
    }
  }

  SearchService._();

  CollectionReference<Map<String, dynamic>> get userCollection =>
      FirebaseFirestore.instance.collection("Users");

  Future<List<MyUser>>? search(
      String il, String ilce, String brans, String mevki) async {
    QuerySnapshot<Map<String, dynamic>> maps = await userCollection
        .where("il", isEqualTo: il)
        .where("ilce", isEqualTo: ilce)
        .where("brans", isEqualTo: brans)
        .where("mevki", isEqualTo: mevki)
        .get();
    return maps.docs.map((e) => MyUser.fromMap(e.data())).toList();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> searchStream(
      String il, String ilce, String brans, String mevki) {
    return userCollection
        .where("il", isEqualTo: il)
        .where("ilce", isEqualTo: ilce)
        .where("brans", isEqualTo: brans)
        .where("mevki", isEqualTo: mevki)
        .snapshots();
  }
}

class SearchService2 {
  bool isHaveProfile = false;

  static SearchService2? _instance;

  factory SearchService2() {
    if (_instance != null) {
      return _instance!;
    } else {
      _instance = SearchService2._();
      return _instance!;
    }
  }

  SearchService2._();

  CollectionReference<Map<String, dynamic>> get userCollection =>
      FirebaseFirestore.instance.collection("Users");

  Future<List<MyUser>>? search(
      String il, String ilce, String brans, String mevki, String sex) async {
    QuerySnapshot<Map<String, dynamic>> maps = await userCollection
        .where("il", isEqualTo: il)
        .where("ilce", isEqualTo: ilce)
        .where("brans", isEqualTo: brans)
        .where("mevki", isEqualTo: mevki)
        .where("sex", isEqualTo: sex)
        .get();
    return maps.docs.map((e) => MyUser.fromMap(e.data())).toList();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> searchStream1(
      String il, String ilce, String brans, String mevki, String sex) {
    return userCollection
        .where("il", isEqualTo: il)
        .where("ilce", isEqualTo: ilce)
        .where("brans", isEqualTo: brans)
        .where("mevki", isEqualTo: mevki)
        .where("sex", isEqualTo: sex)
        .snapshots();
  }
}

class ReadControl {
  bool isHaveProfile = false;

  static ReadControl? _instance;

  factory ReadControl() {
    if (_instance != null) {
      return _instance!;
    } else {
      _instance = ReadControl._();
      return _instance!;
    }
  }
  var I = AuthService().user!.id;
  ReadControl._();

  CollectionReference<Map<String, dynamic>> get userCollection =>
      FirebaseFirestore.instance.collection("konusmalar");

  Future<List<Konusma>> search() async {
    QuerySnapshot<Map<String, dynamic>> maps = await userCollection
        .where("kimle_konusuyor", isEqualTo: I)
        .where("goruldu", isEqualTo: "false")
        .get();
    return maps.docs.map((e) => Konusma.fromMap(e.data())).toList();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> ReadStream() {
    return userCollection
        .where("kimle_konusuyor", isEqualTo: I)
        .where("goruldu", isEqualTo: "false")
        .snapshots();
  }
}

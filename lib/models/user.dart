// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:version1/models/medya.dart';

class MyUser {
  String? soyisim;
  String? image;
  String? email;
  String? userName;
  String? id;
  String? il;
  String? ilce;
  String? brans;
  String? mevki;
  int? yas;
  String? sex;
  String? bio;
  bool? premium;
  List<Medya>? gPic;
  String? token;
  List<String>? takip = [];

  MyUser(
      {this.soyisim,
      this.gPic,
      this.image,
      this.email,
      this.userName,
      this.id,
      this.il,
      this.ilce,
      this.brans,
      this.mevki,
      this.yas,
      this.sex,
      this.bio,
      this.token,
      this.takip,
      this.premium = false});

  MyUser copyWith({
    String? token,
    String? soyisim,
    String? image,
    String? email,
    String? userName,
    String? id,
    String? il,
    String? ilce,
    String? brans,
    String? mevki,
    int? yas,
    String? sex,
    String? bio,
    bool? premium,
    List<Medya>? gPic,
    List<String>? takip,
  }) {
    return MyUser(
      takip: takip ?? this.takip,
      token: token ?? this.token,
      soyisim: soyisim ?? this.soyisim,
      gPic: gPic ?? this.gPic,
      image: image ?? this.image,
      email: email ?? this.email,
      userName: userName ?? this.userName,
      id: id ?? this.id,
      il: il,
      ilce: ilce,
      brans: brans,
      mevki: mevki,
      yas: yas ?? this.yas,
      sex: sex ?? this.sex,
      bio: bio ?? this.bio,
      premium: premium ?? this.premium,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'takip': takip,
      'token': token,
      'soyisim': soyisim,
      'image': image,
      'email': email,
      'userName': userName ??
          email!.substring(0, email?.indexOf('@')) + randomSayiUret(),
      'id': id,
      'il': il,
      'ilce': ilce,
      'brans': brans,
      'mevki': mevki,
      'yas': yas,
      'sex': sex,
      'premium': premium,
      'gPic': gPic?.map((e) => e.toMap()).toList(),
      'bio': bio,
    };
  }

  factory MyUser.fromMap(Map<String, dynamic> map) {
    return MyUser(
      takip: map['takip'] != null
          ? (map['takip'] as List).map((e) => e.toString()).toList()
          : [],
      token: map['token'] != null ? map['token'] as String : null,
      soyisim: map['soyisim'] != null ? map['soyisim'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      userName: map['userName'] != null ? map['userName'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
      il: map['il'] != null ? map['il'] as String : null,
      ilce: map['ilce'] != null ? map['ilce'] as String : null,
      brans: map['brans'] != null ? map['brans'] as String : null,
      mevki: map['mevki'] != null ? map['mevki'] as String : null,
      yas: map['yas'] != null ? map['yas'] as int : null,
      sex: map['sex'] != null ? map['sex'] as String : null,
      bio: map['bio'] != null ? map['bio'] as String : null,
      premium: map['premium'] != null ? map['premium'] as bool : null,
      gPic: map['gPic'] != null
          ? (map['gPic'] as List).map((e) => Medya.fromMap(e)).toList()
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyUser.fromJson(String source) =>
      MyUser.fromMap(json.decode(source) as Map<String, dynamic>);
  MyUser.idveResim({@required this.id});

  @override
  String toString() {
    return 'MyUser(token: $token, image: $image, email: $email, userName: $userName, id: $id, il: $il, ilce: $ilce, brans: $brans, soyisim: $soyisim, mevki: $mevki, yas: $yas, sex: $sex, bio: $bio, gPic: $gPic)';
  }

  @override
  bool operator ==(covariant MyUser other) {
    if (identical(this, other)) return true;

    return other.image == image &&
        other.email == email &&
        other.token == token &&
        other.userName == userName &&
        other.id == id &&
        other.il == il &&
        other.ilce == ilce &&
        other.brans == brans &&
        other.mevki == mevki &&
        other.yas == yas &&
        other.sex == sex &&
        other.soyisim == soyisim &&
        other.bio == bio &&
        other.gPic == gPic;
  }

  @override
  int get hashCode {
    return image.hashCode ^
        token.hashCode ^
        email.hashCode ^
        userName.hashCode ^
        id.hashCode ^
        il.hashCode ^
        ilce.hashCode ^
        brans.hashCode ^
        mevki.hashCode ^
        yas.hashCode ^
        sex.hashCode ^
        bio.hashCode ^
        soyisim.hashCode ^
        gPic.hashCode;
  }

  String randomSayiUret() {
    int rastgeleSayi = Random().nextInt(999999);
    return rastgeleSayi.toString();
  }
}

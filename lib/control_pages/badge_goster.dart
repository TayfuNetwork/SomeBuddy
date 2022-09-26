import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/konusma.dart';
import '../services/auth_service.dart';
import '../services/search_service.dart';
import '../pages/gelen_kutusu.dart';

class baddge extends StatefulWidget {
  const baddge({Key? key}) : super(key: key);

  @override
  State<baddge> createState() => _baddgeState();
}
Text? Texxt;
var I = AuthService().user!.id;

class _baddgeState extends State<baddge> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: ReadControl().ReadStream(),
        builder: (c, snap) {
          if (snap.hasData) {
            List<Konusma> mesajlar =
                snap.data!.docs.map((e) => Konusma.fromMap(e.data())).toList();

            mesajlar.map((e) => {}).toList();
            return Badge(
                badgeColor: Colors.white,
                animationDuration: Duration(milliseconds: 300),
                position: BadgePosition.topEnd(top: 10, end: 10),
                animationType: BadgeAnimationType.slide,
                badgeContent: Text(
                  mesajlar.length.toString(),
                  style: TextStyle(color: Colors.red),
                ),
                child: IconButton(
                  onPressed: _mesajlaraGit,
                  icon: Icon(Icons.chat),
                ));
          } else {
            return Text("?");
          }
        });
  }

  _mesajlaraGit() {
    return Navigator.of(context)
        .push(CupertinoPageRoute(builder: (context) => Inbox()));
  }
}

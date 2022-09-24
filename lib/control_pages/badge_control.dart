import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../pages/gelen_kutusu.dart';


class badge_control extends StatefulWidget {
  badge_control({Key? key}) : super(key: key);

  @override
  State<badge_control> createState() => _badge_controlState();
}

@override
void initState() {
  Inbox();
}

late int acounter = 0;

class _badge_controlState extends State<badge_control> {
  @override
  Widget build(BuildContext context) {
    
    return Badge(
        badgeColor: Colors.white,
        animationDuration: Duration(milliseconds: 300),
        position: BadgePosition.topEnd(top: 10, end: 10),
        animationType: BadgeAnimationType.slide,
        badgeContent: Text(
          acounter.toString(),
          style: TextStyle(color: Colors.red),
        ),
        child: IconButton(
          onPressed: _mesajlaraGit,
          icon: Icon(Icons.chat),
        ));
  }

  _mesajlaraGit() {
    return Navigator.of(context)
        .push(CupertinoPageRoute(builder: (context) => Inbox()));
  }


}

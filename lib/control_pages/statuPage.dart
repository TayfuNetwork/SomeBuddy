import 'package:flutter/material.dart';

class createStatuPage extends StatefulWidget {
  const createStatuPage({super.key});

  @override
  State<createStatuPage> createState() => _createStatuPageState();
}

class _createStatuPageState extends State<createStatuPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      AlertDialog(
        content: Card(
          child: TextField(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        actions: <Widget>[Text("İzinVer")],
      )
    ]);
  }
}

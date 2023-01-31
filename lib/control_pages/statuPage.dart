// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';

class createStatuPage extends StatefulWidget {
  const createStatuPage({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  State<createStatuPage> createState() => _createStatuPageState();
}

class _createStatuPageState extends State<createStatuPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        "images/background.png",
        width: double.maxFinite,
        height: double.maxFinite,
      ),
      Positioned.fill(
        child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 15,
              sigmaY: 15,
            ),
            child: Positioned.fill(
              child: widget.child,
            )),
      ),
    ]);
  }
}

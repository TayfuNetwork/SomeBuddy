import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:version1/control_pages/landing_page.dart';
import 'package:version1/pages/show.dart';

import 'package:version1/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AuthService().checkUser();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SomeBuddy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const //show()
          LandingPage(),
      //theme değiştirilebilir.
    );
  }
}

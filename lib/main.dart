import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:version1/control_pages/landing_page.dart';
import 'package:version1/services/ad_helper.dart';
import 'package:version1/services/auth_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AuthService().checkUser();
  MobileAds.instance.initialize();
  adHelper.createInterstitialAd();
  adHelper.createRewardedAd();
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
      home: const LandingPage(),
      //theme değiştirilebilir.
    );
  }
}

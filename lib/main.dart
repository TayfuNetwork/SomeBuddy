import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:version1/control_pages/landing_page.dart';
import 'package:version1/control_pages/statuPage.dart';
import 'package:version1/services/ad_helper.dart';
import 'package:version1/services/auth_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:version1/services/notification.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: NotificationService.currentPlatform);
  await setupFlutterNotifications();
}

GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

void showSnack(String text) {
  if (_scaffoldKey.currentContext != null) {
    ScaffoldMessenger.of(_scaffoldKey.currentContext!)
        .showSnackBar(SnackBar(content: Text(text)));
  }
}

Future<void> checkForUpdate() async {
  try {
    AppUpdateInfo info = await InAppUpdate.checkForUpdate();
    if (info.updateAvailability == UpdateAvailability.updateAvailable) {
      try {
        await InAppUpdate.performImmediateUpdate();
      } on Exception catch (e) {
        ScaffoldMessenger.of(_scaffoldKey.currentContext!)
            .showSnackBar(SnackBar(content: Text("$e")));
      }
    }
  } on Exception catch (e) {
    ScaffoldMessenger.of(_scaffoldKey.currentContext!)
        .showSnackBar(SnackBar(content: Text("$e")));
  }
}

Future<void> setupFlutterNotifications() async {
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.max,
  );
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(android: AndroidInitializationSettings("logo")));
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  checkForUpdate();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: NotificationService.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (!kIsWeb) {
    await setupFlutterNotifications();
  }
  await AuthService().checkUser();
  await MobileAds.instance.initialize();
  await adHelper.createInterstitialAd();
  await adHelper.createRewardedAd();
  runApp(EasyLocalization(
    supportedLocales: [
      Locale('en', 'US'),
      Locale('tr', 'TR'),
    ],
    path: 'assets/translations',
    fallbackLocale: Locale('en', 'US'),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.deviceLocale,
      title: 'SomeBuddy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const LandingPage(),
    );
  }
}

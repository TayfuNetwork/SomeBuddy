import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:version1/pages/bilgilerim.dart';
import 'package:version1/pages/profil.dart';
import 'package:version1/pages/sign_in_page.dart';
import 'package:version1/services/auth_service.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => LandingPageState();
}

var flp = FlutterLocalNotificationsPlugin();
Future<void> kurulum() async {
  var androidAyari = AndroidInitializationSettings("@mipmap/ic_launcher");
  var iosAyari = IOSInitializationSettings();
  var kurulumAyari =
      InitializationSettings(android: androidAyari, iOS: iosAyari);
  await flp.initialize(kurulumAyari, onSelectNotification: bildirimSecilme);
}

Future<void> bildirimSecilme(String? payload) async {
  if (payload != null) {
    print("Bildirim seçildi : $payload");
  }
}

Future<void> bildirimGoster() async {
  var androidBildirimDetayi = AndroidNotificationDetails(
      "kanal id", "kanal baslik",
      channelDescription: "kanal içerik",
      priority: Priority.high,
      importance: Importance.max);

  var iosBildirimDetayi = IOSNotificationDetails();
  var bildirimDetayi = NotificationDetails(
      android: androidBildirimDetayi, iOS: iosBildirimDetayi);
  await flp.show(
      0, "Premium olmak çok kolay !", "Tıkla ve öğren", bildirimDetayi,
      payload: "Payload içerik");
}

Future<void>? call() {
  var userr = AuthService().user!.premium;
  if (userr != true) {
    return bildirimGoster();
  }
  return null;
}

@override
void initState() {
  kurulum();
}

class LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      return const SignInPage();
    } else {
      if (AuthService().isHaveProfile) {
        call();
        return const bilgilerim();
      } else {
        return const Profile();
      }
    }
  }
}

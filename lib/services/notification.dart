import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  bildirimAyarlari(String? Token) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }

    /* vapidKey:
    "$Token"; */

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  String constructFCMPayload(String? token, String? tittle, String? body) {
    return jsonEncode({
      "to": "$token",
      "priority": "high",
      "notification": {"title": "$tittle", "body": "$body"}
    });
  }

  Future<void> sendPushMessage(
      String? token, String tittle, String body) async {
    if (token == null) {
      return print("token geçersiz");
    }

    try {
      await http.post(
        Uri.parse(
            'https://fcm.googleapis.com/v1/projects/project-160528578459/messages:send HTTP/1.1'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer AAAAJWA_t5s:APA91bFrswOw2z4L65FjqRmzu_UxVIxhICjsQOL0eyScK6P-oqYxcxIZYieRUHfn1InfroaN0qkt0DpjzIkk1pzfsGOcUHvJzR-yyDYeSRBydqOJTTar0u7uPtN2j9HSV9RJ58oStb12'
        },
        body: constructFCMPayload(token, tittle, body),
      );
    } catch (e) {}
  }

  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;

      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC2vIcldpxgupEm676Z5uGJsxcjDRiWgZg', // tamam
    appId: '1:160528578459:web:80306c5335734349d5d33e', // tamam
    messagingSenderId: '160528578459', // tamam
    projectId: 'birini-bul', // tamam
    authDomain: 'birini-bul.firebaseapp.com', // tamam
    databaseURL: 'https://birini-bul-default-rtdb.firebaseio.com', // tamam
    storageBucket: 'birini-bul.appspot.com', // tamam
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA-PV-s9HDhncIYHG_Lnab6pziFPFYORk8', // tamam
    appId: '1:160528578459:android:73784fd4d9c73005d5d33e', // tamam
    messagingSenderId: '160528578459', //tamam
    projectId: 'birini-bul', // tamam
    databaseURL: 'https://birini-bul-default-rtdb.firebaseio.com', //tamam
    storageBucket: 'birini-bul.appspot.com', // tamam
  );
}

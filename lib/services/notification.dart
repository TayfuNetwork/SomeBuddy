import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NotificationService {
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
        Uri.parse('https://api.rnfirebase.io/messaging/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAJWA_t5s:APA91bFrswOw2z4L65FjqRmzu_UxVIxhICjsQOL0eyScK6P-oqYxcxIZYieRUHfn1InfroaN0qkt0DpjzIkk1pzfsGOcUHvJzR-yyDYeSRBydqOJTTar0u7uPtN2j9HSV9RJ58oStb12'
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
    appId: '1:160528578459:web:73784fd4d9c73005d5d33e', // tamam
    messagingSenderId: '160528578459', // tamam
    projectId: 'birini-bul', // tamam
    authDomain: 'react-native-firebase-testing.firebaseapp.com',
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

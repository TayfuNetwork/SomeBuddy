import 'dart:convert';

import 'package:http/http.dart' as http;

class NotificationService {
  String constructFCMPayload(String token, String tittle, String body) {
    return jsonEncode({
      'to': token,
      'priority': 'high',
      'notification': {
        'title': tittle,
        'body': body,
      },
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
    } catch (e) {
     
    }
  }
}

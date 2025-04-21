import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FCM {
  static int _messageCount = 0;
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static var _serverKey =
      'AAAAAUhpyMI:APA91bGLXldNFtN4OBmeMk6NRLJLQy6561k9qX6mCkWyYGgtzBmX_MlgLXS5EQwJdFxOKRrnpoFICU6z9_KGpupCDckjBM9bIZMC6feuZ_tCpvVKZvIK3akJsP_pyBgJ1R-LC12jyTJG';

  static String _constructFCMPayload(String? token) {
    _messageCount++;
    return jsonEncode({
      'token': token,
      'data': {
        'via': 'FlutterFire Cloud Messaging!!!',
        'count': _messageCount.toString(),
      },
      'notification': {
        'title': 'Hello FlutterFire!',
        'body': 'This notification (#$_messageCount) was created via FCM!',
      },
    });
  }

  static Future<void> sendPushMessage(String token) async {
    try {
      await http.post(
        Uri.parse('https://api.rnfirebase.io/messaging/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'key=$_serverKey',
        },
        body: _constructFCMPayload(token),
      );
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
  }

  static Future<String?> generateToken() async {
    if (Platform.isIOS) {
      var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );

      NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: false,
        provisional: true,
        sound: true,
      );
      if (settings.authorizationStatus != AuthorizationStatus.authorized) {
        return null;
      }
    }
    return await _firebaseMessaging.getToken();
  }

  static Future<String> sendMessageSingle(String notificationTitle, String notificationBody, String token, Map<String, dynamic>? data,
      {bool isWeb = false}) async {
    var headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=$_serverKey',
    };
    final notificationData = data ?? <String, dynamic>{};

    String corsUrl = "https://corsproxy.io/?";
    isWeb = GetPlatform.isWeb;

    notificationData["click_action"] = "FLUTTER_NOTIFICATION_CLICK";
    var body = jsonEncode(
      <String, dynamic>{
        'notification': <String, dynamic>{
          'body': notificationBody,
          'title': notificationTitle,
        },
        'priority': 'high',
        'data': notificationData,
        'to': token,
        "apns": {
          "payload": {
            "aps": {"badge": 1},
            "messageID": "ABCDEFGHIJ"
          }
        },
      },
    );

    http.Response response = await http.post(
      Uri.parse('${isWeb ? corsUrl : ''}https://fcm.googleapis.com/fcm/send'),
      headers: headers,
      body: body,
    );

    return response.body;
  }

  static Future<String> sendMessageMulti(String notificationTitle, String notificationBody, List<String> tokens, {bool isWeb = false}) async {
    var headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=$_serverKey',
    };

    String corsUrl = "https://corsproxy.io/?";
    isWeb = GetPlatform.isWeb;

    var body = jsonEncode(
      <String, dynamic>{
        'notification': <String, dynamic>{'body': notificationBody, 'title': notificationTitle},
        'priority': 'high',
        'data': <String, dynamic>{'click_action': 'FLUTTER_NOTIFICATION_CLICK', 'id': '1', 'status': 'done'},
        'registration_ids': tokens,
      },
    );

    print(body);

    http.Response response = await http.post(
      Uri.parse('${isWeb ? corsUrl : ''}https://fcm.googleapis.com/fcm/send'),
      headers: headers,
      body: body,
    );

    return response.body;
  }

  static Future<String> sendMessageToTopic(
      String notificationTitle,
      String notificationBody,
      String topic,
      Map<String, dynamic>? data,
      ) async {
    var _headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=$_serverKey',
    };
    String corsUrl = "https://corsproxy.io/?";

    final notificationData = data ?? Map<String, dynamic>();
    notificationData["click_action"] = "FLUTTER_NOTIFICATION_CLICK";
    var _body = jsonEncode(
      <String, dynamic>{
        'notification': <String, dynamic>{
          'body': '$notificationBody',
          'title': '$notificationTitle',
        },
        'priority': 'high',
        'data': notificationData,
        'to': "/topics/$topic",
        "apns": {
          "payload": {
            "aps": {"badge": 1},
            "messageID": "ABCDEFGHIJ"
          }
        },
      },
    );

    http.Response response = await http.post(
      Uri.parse(corsUrl + 'https://fcm.googleapis.com/fcm/send'),
      headers: _headers,
      body: _body,
    );

    return response.body;
  }

  static Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  static Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }
}

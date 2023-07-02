import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:submission_2_restaurant_app/data/model/restaurant.dart';
import 'package:submission_2_restaurant_app/data/model/notification.dart';

final selectNotificationSubject = BehaviorSubject<String?>();
final didReceiveLocalNotificationSubject = BehaviorSubject<ReceivedNotification>();

class NotificationHelper {
  static const _channelId = '01';
  static const _channelName = 'channel_01';
  static const _channelDesc = 'dicoding channel';
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotification(FlutterLocalNotificationsPlugin plugin) async {
    var initializationSettingsAndroid = const AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        didReceiveLocalNotificationSubject.add(
          ReceivedNotification(id: id, title: title, body: body, payload: payload)
        );
      },
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS
    );

    await plugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) async {
        final payload = response.payload;
        
        if (payload != null) {
          print('notification payload: $payload');
        }

        selectNotificationSubject.add(payload ?? 'empty payload');
      }
    );
  }

  void requestPermissionIOS(FlutterLocalNotificationsPlugin plugin) {
    plugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
      alert: true,
      badge: true,
      sound: true
    );
  }

  // for old ios version
  void configureDidReceiveLocalNotificationSubject(BuildContext context, String route) {
    didReceiveLocalNotificationSubject.stream.listen((ReceivedNotification notification) async {
      await showDialog(
        context: context, 
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: notification.title != null ? Text(notification.title!) : null,
          content: notification.body != null ? Text(notification.body!) : null,
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('OK'),
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.pushNamed(context, route, arguments: notification);
              },
            )
          ],
        )
      );
    });
  }

  Future<void> showNotification(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin, RestaurantResult restaurantResult) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      _channelId, 
      _channelName,
      channelDescription: _channelDesc,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker'
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    var randomIndex = Random().nextInt(restaurantResult.restaurants.length);
    var restaurant = restaurantResult.restaurants[randomIndex];

    await flutterLocalNotificationsPlugin.show(
      0,
      'Here\'s a new our restaurant list',
      restaurant.name,
      platformChannelSpecifics,
      payload: restaurant.id,
    );
  }

  void configureSelectNotificationSubject(BuildContext context, String route) {
    selectNotificationSubject.stream.listen((payload) async {
      await Navigator.pushNamed(context, route, arguments: payload);
    });
  }
}
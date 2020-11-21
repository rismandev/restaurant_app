import 'dart:convert';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:siresto_app/data/model/index.dart';

/*  Notification Helper
    Handle Notification
    [initNotifications] => Initialize Configuration for notifications
    [showNotification] => Configuration for show notification
    [configureSelectNotificationSubject] => Handle Notification On Select the Subject

    Date Created                      Date Updated
    21 November 2020                  21 November 2020

    Created by                        Updated by
    Risman Abdilah                    Risman Abdilah
*/

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  ) async {
    var initSettingsAndroid = AndroidInitializationSettings('app_icon');

    var initSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String payload) async {
        if (payload != null) {
          print('notification payload: ' + payload);
        }
        selectNotificationSubject.add(payload);
      },
    );
  }

  Future<void> showNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    MerchantResult merchantResult,
  ) async {
    var _channelId = "siresto-channel-1";
    var _channelName = "siresto-app";
    var _channelDescription = "Channel Notification siresto app";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      _channelId,
      _channelName,
      _channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: DefaultStyleInformation(true, true),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    final _random = new Random();
    var merchant = merchantResult.dataList[_random.nextInt(
      merchantResult.dataList.length,
    )];
    var _titleNotification = "<b>Daily News</b> - ${merchant.name}";
    var _titleName = merchant.description;

    await flutterLocalNotificationsPlugin.show(
      0,
      _titleNotification,
      _titleName,
      platformChannelSpecifics,
      payload: jsonEncode(merchant.toJson()),
    );
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
      (String payload) async => print(payload),
    );
  }
}

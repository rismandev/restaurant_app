import 'dart:isolate';

import 'dart:ui';

import 'package:siresto_app/data/api/api_merchant.dart';
import 'package:siresto_app/data/helper/notification_helper.dart';
import 'package:siresto_app/main.dart';

/*  Background Service Function
    Handle Background Service
    [initializeIsolate] => Register Port & isolate
    [callback] => Function to handle received alarm & display a notification

    Date Created                      Date Updated
    21 November 2020                  21 November 2020

    Created by                        Updated by
    Risman Abdilah                    Risman Abdilah
*/

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService _service;
  static String _isolateName = 'isolate';
  static SendPort _uiSendPort;

  BackgroundService._createObject();

  factory BackgroundService() {
    if (_service == null) {
      _service = BackgroundService._createObject();
    }
    return _service;
  }

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
  }

  static Future<void> callback() async {
    final NotificationHelper _notificationHelper = NotificationHelper();

    var result = await ApiMerchant().fetchAllMerchant();

    await _notificationHelper.showNotification(
      flutterLocalNotificationsPlugin,
      result,
    );

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }

  Future<void> someTask() async {
    print('Execute some process');
  }
}

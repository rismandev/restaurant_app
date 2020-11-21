import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:siresto_app/data/helper/datetime_helper.dart';
import 'package:siresto_app/utils/background_service.dart';

/*  Scheduling Provider
    Handle Scheduling Notification
    [scheduleDailyNews] => Set active/inactive schedule daily news

    Date Created                      Date Updated
    21 November 2020                  21 November 2020

    Created by                        Updated by
    Risman Abdilah                    Risman Abdilah
*/

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  Future<bool> scheduleDailyNews(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      print('Scheduling Daily News Activated');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      print('Scheduling Daily News Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}

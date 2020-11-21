import 'package:flutter/material.dart';
import 'package:siresto_app/data/helper/preferences_helper.dart';

/*  Preferences Provider
    Handle Action Preferences
    [_getDailyReminderPreferences] => Bool to get daily reminder from helper
    [enableDailyReminder] => Activate/Deactivate daily reminder to helper

    Date Created                      Date Updated
    21 November 2020                  21 November 2020

    Created by                        Updated by
    Risman Abdilah                    Risman Abdilah
*/

class PreferencesProvider extends ChangeNotifier {
  final PreferencesHelper preferencesHelper;

  PreferencesProvider({@required this.preferencesHelper}) {
    _getDailyReminderPreferences();
  }

  bool _isDailyReminder = false;
  bool get isDailyReminder => _isDailyReminder;

  void _getDailyReminderPreferences() async {
    _isDailyReminder = await preferencesHelper.isDailyReminder;
    notifyListeners();
  }

  void enableDailyReminder(bool value) {
    preferencesHelper.setDailyReminder(value);
    _getDailyReminderPreferences();
  }
}

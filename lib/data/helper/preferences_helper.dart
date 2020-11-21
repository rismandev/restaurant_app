import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*  Preferences Helper
    Handle Set Preferences
    [isDailyReminder] => Bool to get daily reminder
    [setDailyReminder] => Activate/Deactivate daily reminder

    Date Created                      Date Updated
    21 November 2020                  21 November 2020

    Created by                        Updated by
    Risman Abdilah                    Risman Abdilah
*/

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({@required this.sharedPreferences});

  static const DAILY_REMINDER = "DAILY_REMINDER";

  Future<bool> get isDailyReminder async {
    final prefs = await sharedPreferences;
    return prefs.getBool(DAILY_REMINDER) ?? false;
  }

  void setDailyReminder(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(DAILY_REMINDER, value);
  }
}

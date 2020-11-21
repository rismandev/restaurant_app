import 'package:flutter/material.dart';
import 'package:siresto_app/data/preferences/preferences_helper.dart';

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

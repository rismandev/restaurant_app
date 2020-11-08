import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation {
  static navigate(
    String routeName, {
    dynamic arguments,
  }) {
    navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  static pushAndRemove(String routeName) {
    navigatorKey.currentState.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
    );
  }

  static back() => navigatorKey.currentState.pop();
}

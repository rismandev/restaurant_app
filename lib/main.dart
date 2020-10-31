import 'package:flutter/material.dart';
import 'package:siresto_app/common/styles.dart';
import 'package:siresto_app/ui/main_page.dart';
import 'package:siresto_app/ui/merchat/detail_page.dart';
import 'package:siresto_app/ui/settings_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIRESTO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: secondaryColor,
        scaffoldBackgroundColor: secondaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: customTextTheme,
      ),
      initialRoute: MainPage.routeName,
      routes: {
        MainPage.routeName: (context) => MainPage(),
        MerchantDetailPage.routeName: (context) {
          return MerchantDetailPage(
            merchant: ModalRoute.of(context).settings.arguments,
          );
        },
        SettingsPage.routeName: (context) => SettingsPage(),
      },
    );
  }
}

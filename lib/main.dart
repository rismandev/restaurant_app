import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siresto_app/common/navigation.dart';
import 'package:siresto_app/common/styles.dart';
import 'package:siresto_app/data/api/api_merchant.dart';
import 'package:siresto_app/data/provider/merchant_provider.dart';
import 'package:siresto_app/ui/main_page.dart';
import 'package:siresto_app/ui/merchat/detail_page.dart';
import 'package:siresto_app/ui/settings_page.dart';
import 'package:siresto_app/ui/splash_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MerchantProvider(apiMerchant: ApiMerchant()),
        ),
      ],
      child: MyApp(),
    ),
  );
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
        appBarTheme: AppBarTheme(
          textTheme: customTextTheme,
          color: primaryBackgroundColor,
          elevation: 0,
        ),
      ),
      navigatorKey: navigatorKey,
      initialRoute: SplashPage.routeName,
      routes: {
        SplashPage.routeName: (context) => SplashPage(),
        MainPage.routeName: (context) => MainPage(),
        MerchantDetailPage.routeName: (context) => MerchantDetailPage(),
        SettingsPage.routeName: (context) => SettingsPage(),
      },
    );
  }
}

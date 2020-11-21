import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siresto_app/common/index.dart';
import 'package:siresto_app/data/api/api_merchant.dart';
import 'package:siresto_app/data/db/database_helper.dart';
import 'package:siresto_app/data/preferences/preferences_helper.dart';
import 'package:siresto_app/data/provider/database_provider.dart';
import 'package:siresto_app/data/provider/merchant_provider.dart';
import 'package:siresto_app/data/provider/preferences_provider.dart';
import 'package:siresto_app/ui/favorite_page.dart';
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
        ChangeNotifierProvider(
          create: (context) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => DatabaseProvider(
            databaseHelper: DatabaseHelper(),
          ),
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
        FavoritePage.routeName: (context) => FavoritePage(),
      },
    );
  }
}

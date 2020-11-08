import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:siresto_app/common/navigation.dart';
import 'package:siresto_app/common/styles.dart';
import 'package:siresto_app/ui/main_page.dart';
import 'package:siresto_app/widgets/custom_platform.dart';

class SplashPage extends StatefulWidget {
  static String routeName = 'splash_page';

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Delay 3 seconds before go to main page
    _goToMainPage();
  }

  Future _goToMainPage() async {
    await Future.delayed(Duration(seconds: 3), () {
      Navigation.pushAndRemove(MainPage.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIOS);
  }

  Scaffold _buildAndroid(BuildContext context) {
    return Scaffold(body: _buildSplash(context));
  }

  CupertinoPageScaffold _buildIOS(BuildContext context) {
    return CupertinoPageScaffold(child: _buildSplash(context));
  }

  Widget _buildSplash(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: primaryBackgroundColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20),
            width: size.width / 1.5,
            child: Image.asset(
              'assets/icons/icon_launch.png',
              fit: BoxFit.cover,
            ),
          ),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}

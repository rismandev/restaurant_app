import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:siresto_app/common/index.dart';
import 'package:siresto_app/data/helper/notification_helper.dart';
import 'package:siresto_app/ui/favorite_page.dart';
import 'package:siresto_app/ui/merchat/detail_page.dart';
import 'package:siresto_app/ui/merchat/list_page.dart';
import 'package:siresto_app/ui/settings_page.dart';
import 'package:siresto_app/utils/background_service.dart';
import 'package:siresto_app/widgets/index.dart';

class MainPage extends StatefulWidget {
  static String routeName = 'main_page';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animationIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    )..addListener(() {
        setState(() {});
      });

    _animationIcon = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);

    _buttonColor = ColorTween(
      begin: primaryBackgroundColor,
      end: Colors.white,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.00, 1.00, curve: Curves.linear),
      ),
    );

    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 0.75, curve: _curve),
      ),
    );
    super.initState();
    port.listen((_) async => await _service.someTask());
    _notificationHelper.configureSelectNotificationSubject(
      MerchantDetailPage.routeName,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
    selectNotificationSubject.close();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIOS);
  }

  Scaffold _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: MerchantListPage(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Transform(
            transform: Matrix4.translationValues(
              0.0,
              _translateButton.value * 2.0,
              0.0,
            ),
            child: buttonSettings(),
          ),
          Transform(
            transform: Matrix4.translationValues(
              0.0,
              _translateButton.value * 1.0,
              0.0,
            ),
            child: buttonFavorite(),
          ),
          buttonMenu()
        ],
      ),
    );
  }

  CupertinoPageScaffold _buildIOS(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: _buildAppBar(context),
      child: MerchantListPage(),
    );
  }

  Widget _buildAppBar(context) {
    if (Platform.isIOS) {
      return CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.fromSTEB(20, 5, 20, 20),
        border: Border.all(style: BorderStyle.none),
        backgroundColor: primaryBackgroundColor,
        leading: Text(
          'SIRESTO',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        trailing: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              child: Icon(
                CupertinoIcons.heart_fill,
                color: Colors.white,
                size: 28,
              ),
              onTap: () => Navigation.navigate(FavoritePage.routeName),
            ),
            SizedBox(width: 10),
            GestureDetector(
              child: Icon(
                CupertinoIcons.settings_solid,
                color: Colors.white,
                size: 28,
              ),
              onTap: () => Navigation.navigate(SettingsPage.routeName),
            ),
          ],
        ),
      );
    }
    return AppBar(
      centerTitle: true,
      title: Text(
        'SIRESTO',
        style: Theme.of(context)
            .textTheme
            .headline5
            .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  void animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget buttonMenu() {
    return Container(
      child: FloatingActionButton(
        heroTag: "menu",
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: "Menu",
        elevation: 2,
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animationIcon,
          color: isOpened ? Colors.grey[900] : Colors.white,
        ),
      ),
    );
  }

  Widget buttonSettings() {
    return Container(
      child: FloatingActionButton(
        heroTag: "settings",
        backgroundColor: primaryBackgroundColor,
        onPressed: () => Navigation.navigate(SettingsPage.routeName),
        tooltip: "Pengaturan",
        child: Icon(Icons.settings, color: Colors.white),
      ),
    );
  }

  Widget buttonFavorite() {
    return Container(
      child: FloatingActionButton(
        heroTag: "favorite",
        backgroundColor: Colors.pinkAccent,
        onPressed: () => Navigation.navigate(FavoritePage.routeName),
        tooltip: "Favorite",
        child: Icon(Icons.favorite, color: Colors.white),
      ),
    );
  }
}

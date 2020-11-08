import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:siresto_app/common/styles.dart';
import 'package:siresto_app/ui/merchat/list_page.dart';
import 'package:siresto_app/ui/settings_page.dart';
import 'package:siresto_app/widgets/custom_platform.dart';

class MainPage extends StatelessWidget {
  static String routeName = 'main_page';

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIOS);
  }

  Scaffold _buildAndroid(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(context), body: MerchantListPage());
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
        trailing: GestureDetector(
          child: Icon(
            Platform.isIOS ? CupertinoIcons.settings_solid : Icons.settings,
            color: Colors.white,
            size: 24,
          ),
          onTap: () => Navigator.pushNamed(context, SettingsPage.routeName),
        ),
      );
    }
    return AppBar(
      title: Text(
        'SIRESTO',
        style: Theme.of(context)
            .textTheme
            .headline6
            .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Platform.isIOS ? CupertinoIcons.settings : Icons.settings,
          ),
          onPressed: () => Navigator.pushNamed(context, SettingsPage.routeName),
        ),
      ],
    );
  }
}

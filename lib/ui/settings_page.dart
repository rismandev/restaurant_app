import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siresto_app/common/index.dart';
import 'package:siresto_app/data/provider/preferences_provider.dart';
import 'package:siresto_app/widgets/index.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  static String routeName = 'settings_page';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIOS);
  }

  Scaffold _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pengaturan')),
      body: _buildContent(context),
    );
  }

  CupertinoPageScaffold _buildIOS(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        actionsForegroundColor: Colors.white,
        backgroundColor: primaryBackgroundColor,
        border: Border.all(style: BorderStyle.none),
        middle: Text(
          'Pengaturan',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        transitionBetweenRoutes: false,
      ),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return ListView(
          children: [
            Material(
              child: ListTile(
                title: Text('Notifikasi'),
                trailing: Switch.adaptive(
                  value: provider.isDailyReminder,
                  onChanged: (value) {
                    if (Platform.isIOS) {
                      comingSoon(context);
                    } else {
                      provider.enableDailyReminder(value);
                    }
                  },
                ),
              ),
            ),
            Material(
              child: ListTile(
                onTap: () => _launchInBrowser(
                  'https://github.com/rismandev/',
                ),
                title: Text('Tautan Github'),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.link),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}

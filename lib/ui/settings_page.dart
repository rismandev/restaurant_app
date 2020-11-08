import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:siresto_app/common/styles.dart';
import 'package:siresto_app/widgets/custom_platform.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  static String routeName = 'settings_page';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  _onChange(bool value) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Segera hadir!'),
            content: Text('Fitur ini akan segera hadir!'),
            actions: [
              FlatButton(
                child: Text('Oke'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('Segera hadir!'),
            content: Text('Fitur ini akan segera hadir!'),
            actions: [
              CupertinoDialogAction(
                child: Text('Oke'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
    }
  }

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
    return ListView(
      children: [
        Material(
          child: ListTile(
            title: Text('Tema Gelap'),
            trailing: Switch.adaptive(value: false, onChanged: _onChange),
          ),
        ),
        Material(
          child: ListTile(
            onTap: () => _launchInBrowser('https://github.com/rismandev/'),
            title: Text('Tautan Github'),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.link),
            ),
          ),
        ),
      ],
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

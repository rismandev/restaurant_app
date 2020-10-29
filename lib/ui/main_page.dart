import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/ui/merchat/list_page.dart';
import 'package:restaurant_app/widgets/custom_platform.dart';
import 'package:restaurant_app/widgets/custom_search.dart';

class MainPage extends StatefulWidget {
  static String routeName = 'main_page';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Searching condition
  bool isSearch = false;

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIOS,
    );
  }

  Scaffold _buildAndroid(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: _buildHeader,
        body: MerchantListPage(),
      ),
    );
  }

  CupertinoPageScaffold _buildIOS(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: _buildHeader,
        body: MerchantListPage(),
      ),
    );
  }

  List<Widget> _buildHeader(context, isScrolled) {
    // When scroll bottom, hide search input
    // When scroll to top, show search input
    if (isScrolled) {
      isSearch = false;
    } else {
      isSearch = true;
    }

    return [
      SliverAppBar(
        pinned: true,
        collapsedHeight: isSearch ? 115 : kToolbarHeight + 1,
        forceElevated: true,
        textTheme: customTextTheme,
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (this.isSearch) ...[
              CustomSearch(
                placeholder: 'Apa yang kamu suka untuk dimakan?',
                onChanged: (value) {
                  // When change input
                },
                onFieldSubmit: (value) {
                  // When click done on keyboard
                },
              ),
            ],
          ],
        ),
        title: Text(
          'SM RESTO',
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
            onPressed: () {
              // When settings clicked
            },
          ),
        ],
      ),
    ];
  }
}

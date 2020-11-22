import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:siresto_app/common/index.dart';
import 'package:siresto_app/data/model/index.dart';
import 'package:siresto_app/data/provider/merchant_provider.dart';
import 'package:siresto_app/widgets/index.dart';

class MerchantDetailPage extends StatefulWidget {
  static String routeName = 'detail_page';

  @override
  _MerchantDetailPageState createState() => _MerchantDetailPageState();
}

class _MerchantDetailPageState extends State<MerchantDetailPage> {
  int indexMenu = 0;

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIOS);
  }

  Scaffold _buildAndroid(BuildContext context) {
    return Scaffold(key: detailScaffold, body: _buildDetailPage(context));
  }

  CupertinoPageScaffold _buildIOS(BuildContext context) {
    return CupertinoPageScaffold(child: _buildDetailPage(context));
  }

  void _changeMenu(int index) {
    setState(() {
      indexMenu = index;
    });
  }

  Widget _buildDetailPage(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailPicture(),
          _detailTitle(context),
          _detailLocation(),
          _detailRating(),
          Container(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Consumer<MerchantProvider>(
              builder: (context, provider, child) {
                if (provider.detailState == ResultState.Loading) {
                  return SkeletonLoader(width: 110, height: 10);
                }
                return Text(
                  'Deskripsi',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(fontWeight: FontWeight.bold),
                );
              },
            ),
          ),
          _detailDescription(),
          Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Row(
              children: [
                _buildButtonMenu(
                  context,
                  isActive: indexMenu == 0,
                  onPressed: () => _changeMenu(0),
                  text: 'Makanan',
                ),
                SizedBox(width: 15),
                _buildButtonMenu(
                  context,
                  isActive: indexMenu == 1,
                  onPressed: () => _changeMenu(1),
                  text: 'Minuman',
                ),
              ],
            ),
          ),
          _detailMenu(),
          DetailReview(),
        ],
      ),
    );
  }

  Consumer<MerchantProvider> _detailMenu() {
    return Consumer<MerchantProvider>(
      builder: (context, MerchantProvider data, child) {
        if (data.detailState == ResultState.Loading) {
          return Container(
            margin: EdgeInsets.fromLTRB(20, 5, 20, 10),
            child: SkeletonLoader(width: double.infinity, height: 90),
          );
        } else {
          if (indexMenu == 0) {
            return _buildListMenu(context, data.detailMerchant.menus.foods);
          } else {
            return _buildListMenu(context, data.detailMerchant.menus.drinks);
          }
        }
      },
    );
  }

  Container _detailDescription() {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Consumer<MerchantProvider>(
        builder: (context, MerchantProvider data, child) {
          if (data.detailState == ResultState.Loading) {
            return _loaderDescription();
          }
          return Text(
            data.detailMerchant.description,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(color: Colors.grey),
          );
        },
      ),
    );
  }

  Consumer<MerchantProvider> _detailRating() {
    return Consumer<MerchantProvider>(
      builder: (context, MerchantProvider data, child) {
        if (data.detailState == ResultState.Loading) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: SkeletonLoader(width: 40, height: 8),
          );
        }
        return _detailRow(
          context,
          text: Text(data.detailMerchant.rating.toString(),
              style: Theme.of(context).textTheme.bodyText2),
        );
      },
    );
  }

  Consumer<MerchantProvider> _detailLocation() {
    return Consumer<MerchantProvider>(
      builder: (context, MerchantProvider data, child) {
        if (data.detailState == ResultState.Loading) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SkeletonLoader(width: 80, height: 8),
          );
        }
        return _detailRow(
          context,
          icon: Icon(
            Platform.isIOS ? CupertinoIcons.location : Icons.location_on,
            size: 18,
            color: Colors.grey,
          ),
          text: Container(
            margin: EdgeInsets.only(left: 5, top: 2),
            child: Text(data.detailMerchant.city,
                style: Theme.of(context).textTheme.bodyText2),
          ),
        );
      },
    );
  }

  Column _loaderDescription() {
    double sizeWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: SkeletonLoader(width: double.infinity, height: 8),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: SkeletonLoader(width: sizeWidth / 1.2, height: 8),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: SkeletonLoader(width: sizeWidth / 2, height: 8),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: SkeletonLoader(width: sizeWidth / 1.2, height: 8),
        ),
      ],
    );
  }

  Container _buildListMenu(
    BuildContext context,
    List<MerchantMenuCategory> items,
  ) {
    return Container(
      width: double.infinity,
      height: 120,
      padding: EdgeInsets.symmetric(horizontal: 0),
      margin: EdgeInsets.only(bottom: 15),
      child: ListView.builder(
        itemCount: items.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.fromLTRB(10, 10, 15, 5),
        itemBuilder: (context, index) => MenuCard(
          item: items[index],
          menu: indexMenu,
          onPressed: () => customAlert(context),
        ),
      ),
    );
  }

  Widget _buildButtonMenu(
    BuildContext context, {
    Function onPressed,
    String text,
    bool isActive = false,
  }) {
    return Consumer<MerchantProvider>(
      builder: (context, provider, child) {
        if (provider.detailState == ResultState.Loading) {
          return Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: SkeletonLoader(width: 100, height: 40),
          );
        }
        return RaisedButton(
          onPressed: onPressed ?? () {},
          color: isActive ? Theme.of(context).primaryColor : Colors.white,
          elevation: 0,
          highlightElevation: 0,
          hoverElevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: Colors.grey.withOpacity(0.3),
              width: 1.5,
              style: isActive ? BorderStyle.none : BorderStyle.solid,
            ),
          ),
          child: Text(
            text ?? 'Button',
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.white : Colors.grey),
          ),
        );
      },
    );
  }

  Container _detailRow(
    BuildContext context, {
    Icon icon,
    Widget text,
  }) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon ??
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 5, 2),
                child: Icon(
                  Platform.isIOS ? CupertinoIcons.star : Icons.star,
                  size: 18,
                  color: Colors.yellow[800],
                ),
              ),
          text ?? Text("", style: Theme.of(context).textTheme.bodyText2),
        ],
      ),
    );
  }

  Container _detailTitle(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
      alignment: Alignment.centerLeft,
      child: Consumer<MerchantProvider>(
        builder: (context, MerchantProvider data, child) {
          if (data.detailState == ResultState.Loading) {
            return SkeletonLoader(width: 150, height: 15);
          }
          return Text(
            data.detailMerchant.name,
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          );
        },
      ),
    );
  }
}

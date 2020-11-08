import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:siresto_app/data/api/api_base.dart';
import 'package:siresto_app/data/model/merchant.dart';
import 'package:siresto_app/data/provider/merchant_provider.dart';
import 'package:siresto_app/widgets/custom_platform.dart';
import 'package:siresto_app/widgets/menu_card.dart';
import 'package:siresto_app/widgets/skeletonloader.dart';

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
    return Scaffold(body: _buildDetailPage(context));
  }

  CupertinoPageScaffold _buildIOS(BuildContext context) {
    return CupertinoPageScaffold(child: _buildDetailPage(context));
  }

  void _changeMenu(int index) {
    setState(() {
      indexMenu = index;
    });
  }

  void _comingSoon() {
    if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Segera hadir!'),
            content: Text('Fitur pemesanan akan segera hadir!'),
            actions: [
              FlatButton(
                child: Text('Oke'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
    } else if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('Segera hadir!'),
            content: Text('Fitur pemesanan akan segera hadir!'),
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

  Widget _buildDetailPage(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _detailPicture(context),
          _detailTitle(context),
          Consumer<MerchantProvider>(
            builder: (context, MerchantProvider data, child) {
              if (data.detailMerchant != null) {
                return _detailRow(
                  context,
                  icon: Icon(
                    Platform.isIOS
                        ? CupertinoIcons.location
                        : Icons.location_on,
                    size: 18,
                    color: Colors.grey,
                  ),
                  text: Container(
                    margin: EdgeInsets.only(left: 5, top: 2),
                    child: Text(data.detailMerchant.city,
                        style: Theme.of(context).textTheme.bodyText2),
                  ),
                );
              }
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: SkeletonLoader(width: 80, height: 8),
              );
            },
          ),
          Consumer<MerchantProvider>(
            builder: (context, MerchantProvider data, child) {
              if (data.detailMerchant != null) {
                return _detailRow(
                  context,
                  text: Text(data.detailMerchant.rating.toString(),
                      style: Theme.of(context).textTheme.bodyText2),
                );
              }
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: SkeletonLoader(width: 40, height: 8),
              );
            },
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Text(
              'Deskripsi',
              style: Theme.of(
                context,
              ).textTheme.subtitle1.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Consumer<MerchantProvider>(
              builder: (context, MerchantProvider data, child) {
                if (data.detailMerchant != null) {
                  return Text(
                    data.detailMerchant.description,
                    style: Theme.of(
                      context,
                    ).textTheme.subtitle1.copyWith(color: Colors.grey),
                  );
                }
                return _loaderDescription();
              },
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
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
          Consumer<MerchantProvider>(
            builder: (context, MerchantProvider data, child) {
              if (data.detailMerchant != null) {
                if (indexMenu == 0) {
                  return _buildListMenu(
                    context,
                    data.detailMerchant.menus.foods,
                  );
                } else {
                  return _buildListMenu(
                    context,
                    data.detailMerchant.menus.drinks,
                  );
                }
              }
              return Container(
                margin: EdgeInsets.fromLTRB(20, 5, 20, 10),
                child: SkeletonLoader(width: double.infinity, height: 90),
              );
            },
          ),
          Container(width: double.infinity, height: 200),
        ],
      ),
    );
  }

  Column _loaderDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: SkeletonLoader(width: double.infinity, height: 8),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: SkeletonLoader(
            width: MediaQuery.of(context).size.width / 1.2,
            height: 8,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: SkeletonLoader(
            width: MediaQuery.of(context).size.width / 2,
            height: 8,
          ),
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
      height: 200,
      child: ListView.builder(
        itemCount: items.length,
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        itemBuilder: (context, index) => MenuCard(
          item: items[index],
          menu: indexMenu,
          onPressed: () => _comingSoon(),
        ),
      ),
    );
  }

  RaisedButton _buildButtonMenu(
    BuildContext context, {
    Function onPressed,
    String text,
    bool isActive = false,
  }) {
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
        style: Theme.of(
          context,
        ).textTheme.subtitle1.copyWith(
            fontWeight: FontWeight.bold,
            color: isActive ? Colors.white : Colors.grey),
      ),
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
          if (data.detailMerchant != null) {
            return Text(
              data.detailMerchant.name,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            );
          }
          return SkeletonLoader(width: 150, height: 8);
        },
      ),
    );
  }

  Container _detailPicture(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Consumer<MerchantProvider>(
            builder: (context, MerchantProvider data, _) {
              if (data.detailMerchant != null) {
                String image = ApiBase.baseImage +
                    'large/' +
                    data.detailMerchant.pictureId;
                return ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                );
              }
              return SkeletonLoader(width: double.infinity, height: null);
            },
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 15,
            width: 60,
            height: 60,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Platform.isIOS
                        ? CupertinoIcons.arrow_left
                        : Icons.arrow_back,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

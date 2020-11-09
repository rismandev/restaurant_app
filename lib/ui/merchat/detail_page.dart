import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:siresto_app/common/index.dart';
import 'package:siresto_app/data/api/api_base.dart';
import 'package:siresto_app/data/api/api_merchant.dart';
import 'package:siresto_app/data/model/index.dart';
import 'package:siresto_app/data/provider/merchant_provider.dart';
import 'package:siresto_app/widgets/index.dart';

class MerchantDetailPage extends StatefulWidget {
  static String routeName = 'detail_page';

  @override
  _MerchantDetailPageState createState() => _MerchantDetailPageState();
}

class _MerchantDetailPageState extends State<MerchantDetailPage> {
  MerchantProvider _merchantProvider = MerchantProvider(
    apiMerchant: ApiMerchant(),
  );
  int indexMenu = 0;

  @override
  void initState() {
    MerchantProvider.reviewNameController = TextEditingController();
    MerchantProvider.reviewTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    MerchantProvider.reviewNameController.dispose();
    MerchantProvider.reviewTextController.dispose();
    print('Disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIOS);
  }

  Scaffold _buildAndroid(BuildContext context) {
    return Scaffold(
      key: detailScaffold,
      body: _buildDetailPage(context),
    );
  }

  CupertinoPageScaffold _buildIOS(BuildContext context) {
    return CupertinoPageScaffold(child: _buildDetailPage(context));
  }

  void _changeMenu(int index) {
    setState(() {
      indexMenu = index;
    });
  }

  _handleSendReview() async {
    _merchantProvider.addCustomerReview().then((value) async {
      if (value is List) {
        await Future.delayed(Duration(seconds: 1), () {
          showCustomSnackBar(
            context,
            text: "Berhasil mengirim ulasan",
          );
        });
      } else {
        await Future.delayed(Duration(seconds: 1), () {
          showCustomSnackBar(
            context,
            text: value,
            backgroundColor: Colors.red[800],
          );
        });
      }
    });
  }

  Widget _buildDetailPage(BuildContext context) {
    this._merchantProvider = Provider.of<MerchantProvider>(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _detailPicture(context),
          _detailTitle(context),
          _detailLocation(),
          _detailRating(),
          Container(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Text(
              'Deskripsi',
              style: Theme.of(
                context,
              ).textTheme.subtitle1.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          _detailDescription(),
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
          _detailMenu(),
          _detailReview(context),
        ],
      ),
    );
  }

  Container _detailReview(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(20, 5, 20, 25),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300],
            offset: Offset.zero,
            blurRadius: 6,
            spreadRadius: 1.5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
            child: CustomField(
              hintText: "Masukkan nama",
              controller: MerchantProvider.reviewNameController,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: CustomField(
              maxLines: 5,
              hintText: "Masukkan ulasan",
              controller: MerchantProvider.reviewTextController,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: RaisedButton(
              onPressed: _handleSendReview,
              color: Colors.green[800],
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Kirim',
                style: Theme.of(context)
                    .textTheme
                    .button
                    .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
            child: Text(
              "Ulasan",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          _buildListReview(),
        ],
      ),
    );
  }

  Widget _buildListReview() {
    return Consumer<MerchantProvider>(
      builder: (context, MerchantProvider data, child) {
        if (data.detailState == ResultState.HasData) {
          List<CustomerReview> items = data.detailMerchant.customerReviews;
          double sizeHeight = items.length > 0 ? 80.0 * items.length : 0;
          return ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: sizeHeight,
            ),
            child: ListView.builder(
              itemCount: items.length,
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ReviewCard(item: items[index]);
              },
            ),
          );
        }

        return Container(
          height: 160.0,
          child: ListView.builder(
            itemCount: 2,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                height: 70,
                margin: EdgeInsets.only(top: 10),
                child: SkeletonLoader(
                  disableBorder: true,
                  width: double.infinity,
                  isCircle: false,
                  height: 70,
                ),
              );
            },
          ),
        );
      },
    );
  }

  Consumer<MerchantProvider> _detailMenu() {
    return Consumer<MerchantProvider>(
      builder: (context, MerchantProvider data, child) {
        if (data.detailState == ResultState.HasData) {
          if (indexMenu == 0) {
            return _buildListMenu(context, data.detailMerchant.menus.foods);
          } else {
            return _buildListMenu(context, data.detailMerchant.menus.drinks);
          }
        }
        return Container(
          margin: EdgeInsets.fromLTRB(20, 5, 20, 10),
          child: SkeletonLoader(width: double.infinity, height: 90),
        );
      },
    );
  }

  Container _detailDescription() {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Consumer<MerchantProvider>(
        builder: (context, MerchantProvider data, child) {
          if (data.detailState == ResultState.HasData) {
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
    );
  }

  Consumer<MerchantProvider> _detailRating() {
    return Consumer<MerchantProvider>(
      builder: (context, MerchantProvider data, child) {
        if (data.detailState == ResultState.HasData) {
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
    );
  }

  Consumer<MerchantProvider> _detailLocation() {
    return Consumer<MerchantProvider>(
      builder: (context, MerchantProvider data, child) {
        if (data.detailState == ResultState.HasData) {
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
        }
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SkeletonLoader(width: 80, height: 8),
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
          onPressed: () => comingSoon(context),
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
          if (data.detailState == ResultState.HasData) {
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
              if (data.detailState == ResultState.HasData) {
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
                onTap: () => Navigation.back(),
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

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:siresto_app/data/model/merchant.dart';
import 'package:siresto_app/widgets/custom_card.dart';
import 'package:siresto_app/widgets/custom_platform.dart';

class MerchantDetailPage extends StatefulWidget {
  static String routeName = 'detail_page';

  final Merchant merchant;

  const MerchantDetailPage({
    Key key,
    @required this.merchant,
  }) : super(key: key);

  @override
  _MerchantDetailPageState createState() => _MerchantDetailPageState();
}

class _MerchantDetailPageState extends State<MerchantDetailPage> {
  int indexMenu = 0;

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIOS,
    );
  }

  Scaffold _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _buildDetailPage(context),
    );
  }

  CupertinoPageScaffold _buildIOS(BuildContext context) {
    return CupertinoPageScaffold(
      child: _buildDetailPage(context),
    );
  }

  void _changeMenu(int index) {
    setState(() {
      indexMenu = index;
    });
  }

  void _commingSoon() {
    if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Segera hadir!'),
            content: Text('Fitur pemesanan akan segera hadir!'),
            actions: [
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Oke'),
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
          _detailRow(
            context,
            icon: Icon(
              Platform.isIOS ? CupertinoIcons.location : Icons.location_on,
              size: 18,
              color: Colors.grey,
            ),
            text: Container(
              margin: EdgeInsets.only(left: 5, top: 2),
              child: Text(
                widget.merchant.city,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ),
          _detailRow(context),
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
            child: Text(
              widget.merchant.description,
              style: Theme.of(
                context,
              ).textTheme.subtitle1.copyWith(color: Colors.grey),
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
          if (indexMenu == 0) ...[
            _buildListMenu(context, widget.merchant.menus.foods),
          ] else ...[
            _buildListMenu(context, widget.merchant.menus.drinks),
          ],
        ],
      ),
    );
  }

  ConstrainedBox _buildListMenu(
    BuildContext context,
    List<MerchantMenuCategory> items,
  ) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: double.infinity,
        minHeight: 200,
        maxWidth: double.infinity,
        maxHeight: items.length > 0 ? items.length * 90.0 : 120,
      ),
      child: ListView.builder(
        itemCount: items.length,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        itemBuilder: (context, index) => _buildItem(items[index], context),
      ),
    );
  }

  CustomCard _buildItem(MerchantMenuCategory item, BuildContext context) {
    return CustomCard(
      onPressed: () {
        _commingSoon();
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 25, 2),
            child: Icon(
              indexMenu == 0 ? Icons.local_restaurant : Icons.local_drink_sharp,
              color: Colors.black,
              size: 30,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    item.name,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 3, 2),
                      child: Icon(
                        Platform.isIOS
                            ? CupertinoIcons.money_dollar
                            : Icons.monetization_on,
                        size: 18,
                        color: Colors.yellow[800],
                      ),
                    ),
                    Text(
                      item.price,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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
              color: isActive ? Colors.white : Colors.grey,
            ),
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
          text ??
              Text(
                widget.merchant.rating.toString(),
                style: Theme.of(context).textTheme.bodyText2,
              ),
        ],
      ),
    );
  }

  Container _detailTitle(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
      alignment: Alignment.centerLeft,
      child: Text(
        widget.merchant.name,
        style: Theme.of(context)
            .textTheme
            .headline5
            .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
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
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
            child: Image.network(widget.merchant.pictureId, fit: BoxFit.cover),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 15,
            width: 60,
            height: 60,
            child: Material(
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

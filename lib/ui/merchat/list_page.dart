import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/common/functions.dart';
import 'package:restaurant_app/data/model/merchant.dart';

class MerchantListPage extends StatefulWidget {
  @override
  _MerchantListPageState createState() => _MerchantListPageState();
}

class _MerchantListPageState extends State<MerchantListPage> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Column(
        children: [
          Expanded(
            child: _buildList(context),
          ),
        ],
      ),
    );
  }

  FutureBuilder<String> _buildList(BuildContext context) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(
        context,
      ).loadString('assets/local_merchant.json'),
      builder: (context, snapshot) {
        final List<Merchant> merchants = parseMerchantToList(snapshot.data);
        return ListView.builder(
          itemCount: merchants.length,
          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          itemBuilder: (context, index) {
            return _buildMerchantItem(context, merchants[index]);
          },
        );
      },
    );
  }

  Widget _buildMerchantItem(BuildContext context, Merchant merchant) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            color: Colors.black.withOpacity(0.15),
            offset: Offset.zero,
            spreadRadius: 1.5,
          ),
        ],
      ),
      child: RaisedButton(
        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.white,
        highlightColor: Theme.of(
          context,
        ).primaryColor.withOpacity(0.15),
        splashColor: Theme.of(
          context,
        ).primaryColor,
        elevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        onPressed: () {
          // When item clicked
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 5, right: 15),
              width: 80,
              height: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  merchant.pictureId,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      merchant.name,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 8, top: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Platform.isIOS
                              ? CupertinoIcons.location
                              : Icons.location_on,
                          size: 18,
                          color: Colors.grey,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                            merchant.city,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyText2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 5, 2),
                        child: Icon(
                          Platform.isIOS
                              ? CupertinoIcons.money_dollar
                              : Icons.monetization_on,
                          size: 18,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        '\$${merchant.price}',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyText2,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 5, 2),
                        child: Icon(
                          Platform.isIOS ? CupertinoIcons.star : Icons.star,
                          size: 18,
                          color: Colors.yellow[800],
                        ),
                      ),
                      Text(
                        merchant.rating.toString(),
                        style: Theme.of(
                          context,
                        ).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // child: buildListTile(merchant, context),
    );
  }
}

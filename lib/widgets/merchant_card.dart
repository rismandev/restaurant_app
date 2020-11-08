import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:siresto_app/data/api/api_base.dart';
import 'package:siresto_app/data/model/merchant.dart';
import 'package:siresto_app/widgets/custom_card.dart';

class MerchantCard extends StatelessWidget {
  final Merchant merchant;
  final Function(Merchant merchant) onPressed;

  const MerchantCard({
    Key key,
    this.merchant,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onPressed: () => onPressed(merchant),
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
                ApiBase.baseImage + 'medium/' + merchant.pictureId,
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
                          style: Theme.of(context).textTheme.bodyText2,
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
                        Platform.isIOS ? CupertinoIcons.star : Icons.star,
                        size: 18,
                        color: Colors.yellow[800],
                      ),
                    ),
                    Text(
                      merchant.rating.toString(),
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
}

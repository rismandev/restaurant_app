import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:siresto_app/data/model/merchant.dart';
import 'package:siresto_app/widgets/custom_card.dart';

class MenuCard extends StatelessWidget {
  final Function onPressed;
  final int menu;
  final MerchantMenuCategory item;

  const MenuCard({
    Key key,
    this.onPressed,
    this.menu,
    this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onPressed: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 25, 2),
            child: Icon(
              menu == 0 ? Icons.local_restaurant : Icons.local_drink_sharp,
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
                    item.name ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                if (item.price != null) ...{
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
                        item.price ?? "",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                }
              ],
            ),
          ),
        ],
      ),
    );
  }
}

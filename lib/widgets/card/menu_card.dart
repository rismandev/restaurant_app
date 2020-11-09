import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:siresto_app/data/model/merchant.dart';

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
    return Container(
      width: 120,
      height: 120,
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
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
      child: Material(
        child: InkWell(
          highlightColor: Theme.of(context).primaryColor.withOpacity(0.2),
          onTap: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                menu == 0 ? Icons.local_restaurant : Icons.local_drink_sharp,
                color: Colors.black,
                size: 30,
              ),
              SizedBox(height: 10),
              Text(
                item.name ?? "",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

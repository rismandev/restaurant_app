import 'package:flutter/material.dart';
import 'package:siresto_app/data/model/customer_review.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    Key key,
    @required this.item,
  }) : super(key: key);

  final CustomerReview item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey[400],
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item.name ?? "",
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
          ),
          Text(
            item.review ?? "",
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(color: Colors.grey[600], fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}

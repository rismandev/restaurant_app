import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final Function onPressed;

  const CustomCard({
    Key key,
    this.child,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        onPressed: onPressed,
        child: this.child,
      ),
    );
  }
}

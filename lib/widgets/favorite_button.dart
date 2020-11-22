import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  final bool isActive;
  final Function onPressed;

  const FavoriteButton({
    Key key,
    this.isActive = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: _defaultDecoration(),
        child: InkWell(
          onTap: onPressed,
          child: Icon(
            Platform.isIOS
                ? CupertinoIcons.heart_fill
                : isActive
                    ? Icons.favorite
                    : Icons.favorite_border,
            color: isActive ? Colors.pinkAccent : Colors.grey[700],
            size: 25,
          ),
        ),
      ),
    );
  }

  BoxDecoration _defaultDecoration() {
    return BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.grey[800].withOpacity(0.3),
          offset: Offset(0, -1),
          blurRadius: 8,
          spreadRadius: 1,
        ),
      ],
    );
  }
}

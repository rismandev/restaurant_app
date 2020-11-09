import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldState> detailScaffold = GlobalKey<ScaffoldState>();

void comingSoon(BuildContext context) {
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

void showCustomSnackBar(
  BuildContext context, {
  String text,
  Color backgroundColor,
  Color textColor,
}) {
  if (Platform.isAndroid) {
    final snackbar = SnackBar(
      backgroundColor: backgroundColor ?? Colors.green[700],
      content: Text(
        text ?? 'text',
        style: Theme.of(context).textTheme.button.copyWith(
            color: textColor ?? Colors.white, fontWeight: FontWeight.w600),
      ),
    );
    detailScaffold.currentState.showSnackBar(snackbar);
  } else {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return CupertinoAlertDialog(
          content: Text(
            text ?? 'text',
            style: Theme.of(context).textTheme.button.copyWith(
                color: textColor ?? Colors.red, fontWeight: FontWeight.w600),
          ),
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

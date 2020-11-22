import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldState> detailScaffold = GlobalKey<ScaffoldState>();

void customAlert(
  BuildContext context, {
  String title,
  String subtitle,
  Function onConfirm,
}) {
  if (Platform.isAndroid) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title ?? 'Segera hadir!'),
          content: Text(subtitle ?? 'Fitur pemesanan akan segera hadir!'),
          actions: [
            if (onConfirm != null) ...{
              FlatButton(
                child: Text(
                  'Batal',
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: Colors.red),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            },
            FlatButton(
              child: Text(
                'Oke',
                style: Theme.of(context)
                    .textTheme
                    .button
                    .copyWith(color: Colors.blue),
              ),
              onPressed: () {
                Navigator.pop(context);
                if (onConfirm != null) onConfirm();
              },
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
          title: Text(title ?? 'Segera hadir!'),
          content: Text(subtitle ?? 'Fitur pemesanan akan segera hadir!'),
          actions: [
            CupertinoDialogAction(
              child: Text('Oke'),
              onPressed: () {
                Navigator.pop(context);
                if (onConfirm != null) onConfirm();
              },
            ),
            if (onConfirm != null) ...{
              CupertinoDialogAction(
                child: Text('Batal'),
                onPressed: () => Navigator.pop(context),
              ),
            },
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
  Duration duration,
}) {
  if (Platform.isAndroid) {
    final snackbar = SnackBar(
      duration: duration ?? Duration(seconds: 2),
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

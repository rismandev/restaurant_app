import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final int maxLines;
  final String hintText;
  final TextEditingController controller;

  const CustomField({
    Key key,
    this.maxLines = 1,
    this.hintText,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          isDense: maxLines > 1 ? true : false,
          contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 10),
          hintText: hintText ?? "Masukkan text",
          border: _defaultBorder(),
        ),
      ),
    );
  }

  OutlineInputBorder _defaultBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Colors.grey[400],
        width: 1,
        style: BorderStyle.solid,
      ),
    );
  }
}

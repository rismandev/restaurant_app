import 'package:flutter/material.dart';

class CustomSearch extends StatelessWidget {
  final ValueChanged onChanged;
  final String placeholder;
  final Function(String value) onFieldSubmit;

  const CustomSearch({
    Key key,
    this.onChanged,
    this.placeholder,
    this.onFieldSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: TextFormField(
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmit,
        decoration: InputDecoration(
          hintText: placeholder ?? 'Search',
          contentPadding: EdgeInsets.fromLTRB(15, 5, 15, 6),
          border: _hideInputBorder(),
          disabledBorder: _hideInputBorder(),
          enabledBorder: _hideInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.blue,
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _hideInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        style: BorderStyle.none,
      ),
    );
  }
}

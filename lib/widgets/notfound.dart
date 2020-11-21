import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  final String title;
  final String icon;
  final String description;

  const NotFound({
    Key key,
    this.title,
    this.description,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 3,
            child: Image.asset(
              icon ?? 'assets/icons/icon_sad.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 5, top: 20),
            child: Text(
              title ?? 'Tempat tidak ditemukan!!',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            description ?? 'Maaf teman, coba cari tempat lain yaa...',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

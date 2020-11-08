import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  const NotFound({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 3,
            child: Image.asset('assets/icons/icon_sad.png', fit: BoxFit.cover),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 5, top: 20),
            child: Text(
              'Tempat tidak ditemukan!!',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            'Maaf temanku, coba cari tempat lain yaa...',
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

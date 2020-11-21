import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siresto_app/common/index.dart';
import 'package:siresto_app/data/api/api_merchant.dart';
import 'package:siresto_app/data/model/index.dart';
import 'package:siresto_app/data/provider/database_provider.dart';
import 'package:siresto_app/data/provider/merchant_provider.dart';
import 'package:siresto_app/ui/merchat/detail_page.dart';
import 'package:siresto_app/widgets/index.dart';

class FavoritePage extends StatefulWidget {
  static String routeName = 'favorite_page';

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  MerchantProvider _merchantProvider = MerchantProvider(
    apiMerchant: ApiMerchant(),
  );

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIOS);
  }

  Scaffold _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tempat Favorit')),
      body: _buildContent(context),
    );
  }

  CupertinoPageScaffold _buildIOS(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        actionsForegroundColor: Colors.white,
        backgroundColor: primaryBackgroundColor,
        border: Border.all(style: BorderStyle.none),
        middle: Text(
          'Tempat Favorit',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        transitionBetweenRoutes: false,
      ),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    this._merchantProvider = Provider.of<MerchantProvider>(context);
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.Loading) {
          return Container(
            alignment: Alignment.center,
            width: double.infinity,
            child: CircularProgressIndicator(
              backgroundColor: Theme.of(context).primaryColor,
            ),
          );
        } else if (provider.state == ResultState.Error) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              provider.message,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: Colors.red, fontWeight: FontWeight.w600),
            ),
          );
        } else if (provider.state == ResultState.NoData) {
          return NotFound(
            title: 'Belum ada tempat favorit!!!',
            icon: 'assets/icons/icon_fav_empty.png',
            description: 'Halo teman,\nAyo tambahkan tempat favoritmu kesini!',
          );
        } else {
          return ListView.builder(
            itemCount: provider.listFavorites.length,
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            itemBuilder: (context, index) {
              return MerchantCard(
                merchant: provider.listFavorites[index],
                onPressed: (Merchant merchant) {
                  _merchantProvider.fetchDetailMerchant(merchant.id);
                  Navigation.navigate(MerchantDetailPage.routeName);
                },
              );
            },
          );
        }
      },
    );
  }
}

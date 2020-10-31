import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:siresto_app/common/functions.dart';
import 'package:siresto_app/common/styles.dart';
import 'package:siresto_app/data/model/merchant.dart';
import 'package:siresto_app/ui/merchat/detail_page.dart';
import 'package:siresto_app/widgets/custom_card.dart';
import 'package:siresto_app/widgets/custom_search.dart';

class MerchantListPage extends StatefulWidget {
  @override
  _MerchantListPageState createState() => _MerchantListPageState();
}

class _MerchantListPageState extends State<MerchantListPage> {
  TextEditingController searchController = TextEditingController();

  List<Merchant> dataMerchants;
  List<Merchant> filterMerchants;

  String query;

  _MerchantListPageState() {
    searchController.addListener(() {
      if (searchController.text.isEmpty) {
        setState(() {
          query = null;
        });
      } else {
        setState(() {
          query = searchController.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: primaryBackgroundColor,
          ),
          child: CustomSearch(
            controller: searchController,
            placeholder: 'Dimana tempat makan favoritemu?',
            onChanged: (value) {
              // When change input
            },
            onFieldSubmit: (value) {
              // When click done on keyboard
            },
          ),
        ),
        Expanded(
          child: query != null ? _performSearch() : _buildList(context),
        ),
      ],
    );
  }

  Widget _performSearch() {
    filterMerchants = new List<Merchant>();

    for (int i = 0; i < dataMerchants.length; i++) {
      var item = dataMerchants[i];

      if (item.name.toLowerCase().contains(query.toLowerCase())) {
        filterMerchants.add(item);
      }
    }

    if (filterMerchants.length > 0) {
      return _buildListMerchant(filterMerchants);
    }

    return _buildItemNotFound();
  }

  FutureBuilder<String> _buildList(BuildContext context) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(
        context,
      ).loadString('assets/local_merchant.json'),
      builder: (context, snapshot) {
        dataMerchants = parseMerchantToList(snapshot.data);
        return _buildListMerchant(dataMerchants);
      },
    );
  }

  ListView _buildListMerchant(List<Merchant> items) {
    return ListView.builder(
      itemCount: items.length,
      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      itemBuilder: (context, index) {
        return _buildMerchantItem(
          context,
          merchant: items[index],
          onPressed: (Merchant merchant) {
            Navigator.pushNamed(
              context,
              MerchantDetailPage.routeName,
              arguments: merchant,
            );
          },
        );
      },
    );
  }

  Container _buildItemNotFound() {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 3,
            child: Image.asset(
              'assets/icons/icon_sad.png',
              fit: BoxFit.cover,
            ),
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

  Widget _buildMerchantItem(
    BuildContext context, {
    Merchant merchant,
    Function(Merchant merchant) onPressed,
  }) {
    return CustomCard(
      onPressed: () => onPressed(merchant),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 5, right: 15),
            width: 80,
            height: 60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                merchant.pictureId,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    merchant.name,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 8, top: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Platform.isIOS
                            ? CupertinoIcons.location
                            : Icons.location_on,
                        size: 18,
                        color: Colors.grey,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Text(
                          merchant.city,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyText2,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 5, 2),
                      child: Icon(
                        Platform.isIOS ? CupertinoIcons.star : Icons.star,
                        size: 18,
                        color: Colors.yellow[800],
                      ),
                    ),
                    Text(
                      merchant.rating.toString(),
                      style: Theme.of(
                        context,
                      ).textTheme.bodyText2,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

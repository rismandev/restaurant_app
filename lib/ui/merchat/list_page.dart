import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siresto_app/common/enum.dart';
import 'package:siresto_app/common/navigation.dart';
import 'package:siresto_app/common/styles.dart';
import 'package:siresto_app/data/api/api_merchant.dart';
import 'package:siresto_app/data/model/merchant.dart';
import 'package:siresto_app/data/provider/merchant_provider.dart';
import 'package:siresto_app/ui/merchat/detail_page.dart';
import 'package:siresto_app/widgets/custom_search.dart';
import 'package:siresto_app/widgets/merchant_card.dart';
import 'package:siresto_app/widgets/notfound.dart';

class MerchantListPage extends StatefulWidget {
  @override
  _MerchantListPageState createState() => _MerchantListPageState();
}

class _MerchantListPageState extends State<MerchantListPage> {
  MerchantProvider merchantProvider = MerchantProvider(
    apiMerchant: ApiMerchant(),
  );

  String query;

  _MerchantListPageState() {
    MerchantProvider.searchController.addListener(() {
      if (MerchantProvider.searchController.text.isEmpty) {
        setState(() {
          query = null;
        });
      } else {
        setState(() {
          query = MerchantProvider.searchController.text;
        });
      }
    });
  }

  @override
  void dispose() {
    MerchantProvider.searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    this.merchantProvider = Provider.of<MerchantProvider>(context);
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(color: primaryBackgroundColor),
          child: CustomSearch(
            controller: MerchantProvider.searchController,
            placeholder: 'Dimana tempat makan favoritemu?',
            onChanged: (value) => merchantProvider.searchMerchant(),
          ),
        ),
        Expanded(
          child: Consumer<MerchantProvider>(
            builder: (context, MerchantProvider data, child) {
              if (data.state == ResultState.HasData) {
                return query != null && data.filterMerchant != null
                    ? _buildListMerchant(data.filterMerchant)
                    : _buildListMerchant(data.listMerchant);
              } else if (data.state == ResultState.Error) {
                return Container(
                  alignment: Alignment.center,
                  child: Text(
                    data.message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.caption.copyWith(
                        color: Colors.red, fontWeight: FontWeight.w600),
                  ),
                );
              } else if (data.state == ResultState.NoData) {
                return NotFound();
              }
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  ListView _buildListMerchant(List<Merchant> items) {
    return ListView.builder(
      itemCount: items.length,
      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      itemBuilder: (context, index) {
        return MerchantCard(
          merchant: items[index],
          onPressed: (Merchant merchant) {
            merchantProvider.fetchDetailMerchant(merchant.id).then((value) {
              if (value is Merchant) {
                Navigation.navigate(MerchantDetailPage.routeName);
              }
            });
          },
        );
      },
    );
  }
}

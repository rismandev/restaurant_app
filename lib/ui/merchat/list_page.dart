import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siresto_app/common/index.dart';
import 'package:siresto_app/data/api/api_merchant.dart';
import 'package:siresto_app/data/model/merchant.dart';
import 'package:siresto_app/data/provider/merchant_provider.dart';
import 'package:siresto_app/ui/merchat/detail_page.dart';
import 'package:siresto_app/widgets/index.dart';

class MerchantListPage extends StatefulWidget {
  @override
  _MerchantListPageState createState() => _MerchantListPageState();
}

class _MerchantListPageState extends State<MerchantListPage> {
  MerchantProvider merchantProvider = MerchantProvider(
    apiMerchant: ApiMerchant(),
  );

  TextEditingController _searchController = TextEditingController();

  String query;

  _MerchantListPageState() {
    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        setState(() {
          query = null;
        });
      } else {
        setState(() {
          query = _searchController.text;
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
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
            controller: _searchController,
            placeholder: 'Dimana tempat makan favoritemu?',
            onChanged: (value) => merchantProvider.searchMerchant(
              query: _searchController.text,
            ),
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
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        margin: EdgeInsets.only(bottom: 25),
                        child: Image.asset(
                          'assets/icons/icon_sad.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        data.message,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5.copyWith(
                            color: Colors.red, fontWeight: FontWeight.w600),
                      ),
                    ],
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
            merchantProvider.fetchDetailMerchant(merchant.id);
            Navigation.navigate(MerchantDetailPage.routeName);
          },
        );
      },
    );
  }
}

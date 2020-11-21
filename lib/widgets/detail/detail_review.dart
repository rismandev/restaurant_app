import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siresto_app/common/index.dart';
import 'package:siresto_app/data/api/api_merchant.dart';
import 'package:siresto_app/data/model/index.dart';
import 'package:siresto_app/data/provider/merchant_provider.dart';
import 'package:siresto_app/widgets/index.dart';

class DetailReview extends StatefulWidget {
  const DetailReview({Key key}) : super(key: key);

  @override
  _DetailReviewState createState() => _DetailReviewState();
}

class _DetailReviewState extends State<DetailReview> {
  MerchantProvider _merchantProvider = MerchantProvider(
    apiMerchant: ApiMerchant(),
  );
  TextEditingController _reviewNameController = TextEditingController();
  TextEditingController _reviewTextController = TextEditingController();

  @override
  void initState() {
    _reviewNameController = TextEditingController();
    _reviewTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _reviewNameController.dispose();
    _reviewTextController.dispose();
    super.dispose();
  }

  _handleSendReview() async {
    String name = _reviewNameController.text;
    String review = _reviewTextController.text;
    _merchantProvider
        .addCustomerReview(name: name, review: review)
        .then((value) async {
      if (value is List) {
        _reviewNameController.clear();
        _reviewTextController.clear();
        await Future.delayed(Duration(milliseconds: 300), () {
          showCustomSnackBar(context, text: "Berhasil mengirim ulasan");
        });
      } else {
        await Future.delayed(Duration(milliseconds: 300), () {
          showCustomSnackBar(
            context,
            text: value,
            backgroundColor: Colors.red[800],
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(20, 5, 20, 25),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300],
            offset: Offset.zero,
            blurRadius: 6,
            spreadRadius: 1.5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<MerchantProvider>(
            builder: (context, provider, child) {
              if (provider.detailState == ResultState.Loading) {
                return Container(
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
                  child: SkeletonLoader(width: double.infinity, height: 45),
                );
              }
              return Container(
                padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
                child: CustomField(
                  hintText: "Masukkan nama",
                  controller: _reviewNameController,
                ),
              );
            },
          ),
          Consumer<MerchantProvider>(
            builder: (context, provider, child) {
              if (provider.detailState == ResultState.Loading) {
                return Container(
                  padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                  child: SkeletonLoader(width: double.infinity, height: 80),
                );
              }
              return Container(
                padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: CustomField(
                  maxLines: 5,
                  hintText: "Masukkan ulasan",
                  controller: _reviewTextController,
                ),
              );
            },
          ),
          Consumer<MerchantProvider>(
            builder: (context, provider, child) {
              if (provider.detailState == ResultState.Loading) {
                return Container(
                  padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                  child: SkeletonLoader(width: 100, height: 40),
                );
              }
              return Container(
                padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: RaisedButton(
                  onPressed: _handleSendReview,
                  color: Colors.green[800],
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Kirim',
                    style: Theme.of(context).textTheme.button.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              );
            },
          ),
          Consumer<MerchantProvider>(
            builder: (context, provider, child) {
              if (provider.detailState == ResultState.Loading) {
                return Container(
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
                  child: SkeletonLoader(width: 100, height: 10),
                );
              }
              return Padding(
                padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
                child: Text(
                  "Ulasan",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor),
                ),
              );
            },
          ),
          _buildListReview(),
        ],
      ),
    );
  }

  Widget _buildListReview() {
    return Consumer<MerchantProvider>(
      builder: (context, MerchantProvider data, child) {
        if (data.detailState == ResultState.Loading) {
          return Container(
            height: 160.0,
            child: ListView.builder(
              itemCount: 2,
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  height: 70,
                  margin: EdgeInsets.only(top: 10),
                  child: SkeletonLoader(
                    disableBorder: true,
                    width: double.infinity,
                    isCircle: false,
                    height: 70,
                  ),
                );
              },
            ),
          );
        } else {
          List<CustomerReview> items = data.detailMerchant.customerReviews;
          double sizeHeight = items.length > 0 ? 80.0 * items.length : 0;
          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: sizeHeight),
            child: ListView.builder(
              itemCount: items.length,
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ReviewCard(item: items[index]);
              },
            ),
          );
        }
      },
    );
  }
}

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siresto_app/common/index.dart';
import 'package:siresto_app/data/api/api_base.dart';
import 'package:siresto_app/data/model/index.dart';
import 'package:siresto_app/data/provider/database_provider.dart';
import 'package:siresto_app/data/provider/merchant_provider.dart';
import 'package:siresto_app/widgets/favorite_button.dart';
import 'package:siresto_app/widgets/index.dart';

class DetailPicture extends StatelessWidget {
  const DetailPicture({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          Consumer<MerchantProvider>(
            builder: (context, MerchantProvider data, _) {
              if (data.detailState == ResultState.Loading) {
                return SkeletonLoader(width: double.infinity, height: null);
              } else if (data.detailMerchant != null) {
                String image = ApiBase.baseImage +
                    'large/' +
                    data.detailMerchant.pictureId;
                return ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                  child: Image.network(image, fit: BoxFit.cover),
                );
              }
              return SizedBox();
            },
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 15,
            width: 50,
            height: 50,
            child: Consumer<MerchantProvider>(
              builder: (context, provider, child) {
                if (provider.detailState == ResultState.Loading) {
                  return SkeletonLoader(width: 50, height: 50, isCircle: true);
                }
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => Navigation.back(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Platform.isIOS
                            ? CupertinoIcons.arrow_left
                            : Icons.arrow_back,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: -20,
            right: 30,
            child: Consumer2<DatabaseProvider, MerchantProvider>(
              builder: (context, databaseProvider, merchantProvider, child) {
                if (merchantProvider.detailState == ResultState.Loading) {
                  return SkeletonLoader(width: 50, height: 50, isCircle: true);
                }
                Merchant merchant = merchantProvider.detailMerchant;
                return FutureBuilder(
                  future: databaseProvider.isFavorite(merchant.id),
                  builder: (context, snapshot) {
                    bool isFavorite = snapshot.data ?? false;
                    return FavoriteButton(
                      isActive: isFavorite,
                      onPressed: () {
                        if (isFavorite) {
                          databaseProvider
                              .removeFavorite(merchant.id)
                              .then((value) {
                            if (value) {
                              showCustomSnackBar(
                                context,
                                text: "Berhasil menghapus dari favorite!",
                                backgroundColor: Colors.green[800],
                                textColor: Colors.white,
                                duration: Duration(milliseconds: 800),
                              );
                            }
                          });
                        } else {
                          databaseProvider.addFavorite(merchant).then((value) {
                            if (value) {
                              showCustomSnackBar(
                                context,
                                text: "Berhasil menambahkan ke favorite!",
                                backgroundColor: Colors.green[800],
                                textColor: Colors.white,
                                duration: Duration(milliseconds: 800),
                              );
                            }
                          });
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

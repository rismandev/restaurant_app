import 'dart:convert';

import 'package:restaurant_app/data/model/merchant.dart';

List<Merchant> parseMerchantToList(String json) {
  if (json == null) {
    return [];
  }

  Map<String, dynamic> parsed = jsonDecode(json);
  List<Merchant> merchants = List<Merchant>();
  parsed['merchants'].forEach((item) {
    merchants.add(Merchant.fromJson(item));
  });
  return merchants.toList();
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:siresto_app/common/enum.dart';
import 'package:siresto_app/data/api/api_merchant.dart';
import 'package:siresto_app/data/model/index.dart';

/*  Merchant Provider Function
    Handle Logic Data Merchant
    [_fetchAllMerchant] => Get List All Merchant
    [searchMerchant] => Search Merchant by query name
    [fetchDetailMerchant] => Get Detail Merchant by id
    [addCustomerReview] => Add Review for Customer

    Date Created                      Date Updated
    08 November 2020                  15 November 2020

    Created by                        Updated by
    Risman Abdilah                    Risman Abdilah
*/

class MerchantProvider extends ChangeNotifier {
  final ApiMerchant apiMerchant;

  MerchantProvider({@required this.apiMerchant}) {
    _fetchAllMerchant();
  }

  List<Merchant> _listMerchant;
  List<Merchant> _filterMerchant;
  Merchant _detailMerchant;
  ResultState _state;
  ResultState _detailState;
  String _message;

  List<Merchant> get listMerchant => _listMerchant;
  List<Merchant> get filterMerchant => _filterMerchant;
  Merchant get detailMerchant => _detailMerchant;
  ResultState get state => _state;
  ResultState get detailState => _detailState;
  String get message => _message;

  Future<dynamic> _fetchAllMerchant() async {
    _state = ResultState.Loading;
    notifyListeners();
    try {
      MerchantResult result = await apiMerchant.fetchAllMerchant();
      if (result.dataList.isNotEmpty) {
        _state = ResultState.HasData;
        notifyListeners();
        return _listMerchant = result.dataList;
      } else {
        _state = ResultState.NoData;
        _message = "Restoran tidak ditemukan";
        notifyListeners();
        return result.message;
      }
    } on SocketException {
      _state = ResultState.Error;
      _message = "Ohhh maaf teman, sepertinya koneksi kamu bermasalah!";
      notifyListeners();
      return _message;
    } catch (e) {
      _state = ResultState.Error;
      _message = "Error $e";
      notifyListeners();
      return "ERROR $e";
    }
  }

  Future<dynamic> searchMerchant({
    @required String query,
  }) async {
    _state = ResultState.Loading;
    notifyListeners();
    try {
      MerchantResult result = await apiMerchant.searchMerchant(query);
      if (result.dataList.isNotEmpty) {
        _state = ResultState.HasData;
        notifyListeners();
        return _filterMerchant = result.dataList;
      } else {
        _state = ResultState.NoData;
        _message = "Restoran tidak ditemukan";
        notifyListeners();
        return result.message;
      }
    } catch (e) {
      _state = ResultState.Error;
      _message = "Error $e";
      notifyListeners();
      return "ERROR $e";
    }
  }

  Future<dynamic> fetchDetailMerchant(String merchantId) async {
    _detailState = ResultState.Loading;
    notifyListeners();
    try {
      MerchantResult result = await apiMerchant.fetchDetailMerchant(merchantId);
      if (result.data != null) {
        _detailState = ResultState.HasData;
        notifyListeners();
        return _detailMerchant = result.data;
      } else {
        _detailState = ResultState.NoData;
        _message = "Restoran tidak ditemukan";
        notifyListeners();
        return result.message;
      }
    } catch (e) {
      _detailState = ResultState.Error;
      _message = "Error $e";
      notifyListeners();
      return "ERROR $e";
    }
  }

  Future<dynamic> addCustomerReview({
    String name = '',
    String review = '',
  }) async {
    String id = _detailMerchant.id;
    CustomerReview data = CustomerReview(
      merchantId: id,
      name: name,
      review: review,
    );
    if (name.isEmpty) {
      return "Silahkan masukkan nama!";
    } else if (review.isEmpty) {
      return "Silahkan masukkan ulasan!";
    }
    _detailState = ResultState.Loading;
    notifyListeners();
    try {
      CustomerReviewResult result = await apiMerchant.addCustomerReview(data);
      if (!result.error) {
        if (result.data != null) {
          _detailState = ResultState.HasData;
          _detailMerchant.customerReviews = result.data.reversed.toList();
          notifyListeners();
        } else {
          _detailState = ResultState.NoData;
          _detailMerchant.customerReviews = List<CustomerReview>();
          notifyListeners();
        }
        return result.data;
      } else {
        _detailState = ResultState.Error;
        _message = result.message;
        notifyListeners();
        return result.message;
      }
    } on SocketException {
      _detailState = ResultState.Error;
      _message = "Ohhh maaf teman, sepertinya koneksi kamu bermasalah!";
      notifyListeners();
      return _message;
    } catch (e) {
      _detailState = ResultState.Error;
      _message = "Error $e";
      notifyListeners();
      return "ERROR $e";
    }
  }
}

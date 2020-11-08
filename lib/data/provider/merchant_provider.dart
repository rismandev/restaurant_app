import 'package:flutter/material.dart';
import 'package:siresto_app/common/enum.dart';
import 'package:siresto_app/data/api/api_merchant.dart';
import 'package:siresto_app/data/model/merchant.dart';

class MerchantProvider extends ChangeNotifier {
  static TextEditingController searchController = TextEditingController();
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
        _message = "Merchant not found";
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

  Future<dynamic> searchMerchant() async {
    _state = ResultState.Loading;
    notifyListeners();
    try {
      String query = searchController.text;
      MerchantResult result = await apiMerchant.searchMerchant(query);
      if (result.dataList.isNotEmpty) {
        _state = ResultState.HasData;
        notifyListeners();
        return _filterMerchant = result.dataList;
      } else {
        _state = ResultState.NoData;
        _message = "Merchant not found";
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
        _message = "Merchant not found";
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
}

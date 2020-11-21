import 'package:flutter/material.dart';
import 'package:siresto_app/common/index.dart';
import 'package:siresto_app/data/db/database_helper.dart';
import 'package:siresto_app/data/model/index.dart';

/*  Database Provider Function
    Handle Logic Local Database
    [_getFavorites] => Get List All Favorite
    [addFavorite] => Add Merchant to List Favorite
    [isFavorite] => Check Merchant Favorite
    [removeFavorite] => Remove Merchant from List Favorite

    Date Created                      Date Updated
    21 November 2020                  21 November 2020

    Created by                        Updated by
    Risman Abdilah                    Risman Abdilah
*/

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({@required this.databaseHelper}) {
    _getFavorites();
  }

  ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Merchant> _listFavorites = [];
  List<Merchant> get listFavorites => _listFavorites;

  void _getFavorites() async {
    _listFavorites = await databaseHelper.getFavorites();
    if (_listFavorites.length > 0) {
      _state = ResultState.HasData;
      notifyListeners();
    } else {
      _state = ResultState.NoData;
      _message = 'Tempat makan favorite kosong!';
      notifyListeners();
    }
  }

  Future<bool> addFavorite(Merchant merchant) async {
    try {
      await databaseHelper.insertFavorite(merchant);
      _getFavorites();
      return true;
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> isFavorite(String id) async {
    final favoriteMerchant = await databaseHelper.getFavoriteById(id);
    return favoriteMerchant.isNotEmpty;
  }

  Future<bool> removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorites();
      return true;
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
      return false;
    }
  }
}

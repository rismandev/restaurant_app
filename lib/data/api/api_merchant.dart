import 'package:siresto_app/data/api/api_base.dart';
import 'package:siresto_app/data/model/index.dart';

/*  Merchant Api Request
    [fetchAllMerchant] => Get List All Merchant
    [fetchDetailMerchant] => Get Detail Merchant by id
    [searchMerchant] => Search Merchant with query
    [addCustomerReview] => Add Customer Reviews

    Date Created                      Date Updated
    08 November 2020                  09 November 2020

    Created by                        Updated by
    Risman Abdilah                    Risman Abdilah
*/

class ApiMerchant extends ApiBase {
  Future<MerchantResult> fetchAllMerchant() async {
    HttpResponseModel response = await this.get('list');
    if (response.statusCode == 200) {
      return MerchantResult.fromJson(response.result);
    } else {
      throw Exception(response.message);
    }
  }

  Future<MerchantResult> fetchDetailMerchant(String id) async {
    HttpResponseModel response = await this.get('detail/$id');
    if (response.statusCode == 200) {
      return MerchantResult.fromJson(response.result);
    } else {
      throw Exception(response.message);
    }
  }

  Future<MerchantResult> searchMerchant(String query) async {
    HttpResponseModel response = await this.get('search?q=$query');
    if (response.statusCode == 200) {
      return MerchantResult.fromJson(response.result);
    } else {
      throw Exception(response.message);
    }
  }

  Future<CustomerReviewResult> addCustomerReview(CustomerReview data) async {
    HttpResponseModel response = await this.post('review', data: data);
    if (response.statusCode == 200) {
      return CustomerReviewResult.fromJson(response.result);
    } else {
      throw Exception(response.message);
    }
  }
}

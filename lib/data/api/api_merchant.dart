import 'package:siresto_app/data/api/api_base.dart';
import 'package:siresto_app/data/model/http_response.dart';
import 'package:siresto_app/data/model/merchant.dart';
import 'package:siresto_app/data/model/review.dart';

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

  Future<ReviewResult> addCustomerReview(CustomerReview data) async {
    HttpResponseModel response = await this.post('review', body: data.toJson());
    if (response.statusCode == 200) {
      return ReviewResult.fromJson(response.result);
    } else {
      throw Exception(response.message);
    }
  }
}

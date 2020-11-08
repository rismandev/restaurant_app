import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:siresto_app/data/api/api_base_type.dart';
import 'package:siresto_app/data/model/http_response.dart';

/*  Base Api Request
    [GET, POST] => RETURN dynamic response
    [_baseUrl] => Change this for More Project
    [baseImage] => Change this for More Project Image path
    [_headers] => Change this for Request Headers
    [responseHandler] => Function to handling all response,
                       You can customize this.

    Date Created                      Date Updated
    08 November 2020                  08 November 2020

    Created by                        Updated by
    Risman Abdilah                    Risman Abdilah
*/

class ApiBase extends ApiBaseType {
  final String _baseUrl = "https://restaurant-api.dicoding.dev/";
  static final String baseImage = "https://restaurant-api.dicoding.dev/images/";

  final Map<String, dynamic> _headers = {
    HttpHeaders.contentTypeHeader: "application/json",
    "X-Auth-Token": "12345",
  };

  @override
  Future<HttpResponseModel> get(String service) async {
    final response = await http.get(_baseUrl + service);
    return responseHandler(response);
  }

  @override
  Future<HttpResponseModel> post(String service, {dynamic body}) async {
    final response = await http.post(
      _baseUrl + service,
      body: jsonEncode(body),
      headers: _headers,
    );
    return responseHandler(response);
  }

  HttpResponseModel responseHandler(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return HttpResponseModel(
          statusCode: response.statusCode,
          message: "Success",
          result: jsonDecode(response.body),
        );
        break;
      case 400:
        return HttpResponseModel(
          statusCode: response.statusCode,
          message: "Bad Request Error!",
          result: null,
        );
        break;
      case 500:
        throw HttpResponseModel(
          statusCode: response.statusCode,
          message: "Internal Server Error!",
          result: null,
        );
      default:
        return HttpResponseModel(
          statusCode: response.statusCode,
          message: "Request Error with status code ${response.statusCode}!",
          result: null,
        );
        break;
    }
  }
}

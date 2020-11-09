class HttpResponseModel {
  int statusCode;
  String message;
  dynamic result;

  HttpResponseModel({this.statusCode, this.message, this.result});
}

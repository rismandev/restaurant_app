abstract class ApiBaseType {
  Future<dynamic> get(String service);
  Future<dynamic> post(String service, {dynamic data});
}

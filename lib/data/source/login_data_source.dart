import 'dart:convert';
import 'package:admin/data/common/http_response_validator.dart';
import 'package:dio/dio.dart';

abstract class ILoginDataSource{
  Future<String> login({required String userName, required String password});
}

class LoginRemoteDataSource with HttpResponseValidator implements ILoginDataSource{
  final Dio httpClient;

  LoginRemoteDataSource(this.httpClient);

  @override
  Future<String> login({required String userName, required String password}) async {
    var formData = json.encode({
  "password": userName,
  "userName": password
});
    httpClient.options.headers['content-Type'] = 'application/json';
    print("res1: ${formData.toString}");
    final response = await httpClient.post("api/Authenticate/login-user", data: formData);
    print("res: $response");
    validateResponse(response);
  //  var body = json.decode(response.data);
    var token = response.data['token'];
    return token;
  }

}


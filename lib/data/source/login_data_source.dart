import 'dart:convert';
import 'package:admin/data/common/http_response_validator.dart';
import 'package:admin/data/models/user.dart';
import 'package:dio/dio.dart';

abstract class ILoginDataSource {
  Future<String> login({required String userName, required String password});
  Future<User> getUser();
}

class LoginRemoteDataSource
    with HttpResponseValidator
    implements ILoginDataSource {
  final Dio httpClient;
  final String token;

  LoginRemoteDataSource(this.httpClient, this.token);

  @override
  Future<String> login(
      {required String userName, required String password}) async {
    var formData = json.encode({"password": password, "userName": userName});
    httpClient.options.headers['content-Type'] = 'application/json';
    print("res1: ${formData.toString}");
    final response =
        await httpClient.post("api/Authenticate/login-user", data: formData);
    print("res: $response");
    validateResponse(response);
    //  var body = json.decode(response.data);
    var token = response.data['token'];
    return token;
  }

  @override
  Future<User> getUser() async {
    httpClient.options.headers['content-Type'] = 'application/json';
    httpClient.options.headers['Authorization'] = 'Bearer $token';
    final response = await httpClient.get("api/UserProfile/GetUser");
    validateResponse(response);
    User user = User.fromJson(response.data);
    return user;
  }
}

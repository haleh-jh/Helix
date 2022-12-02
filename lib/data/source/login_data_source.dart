import 'dart:convert';
import 'package:admin/common/exception.dart';
import 'package:admin/constants.dart';
import 'package:admin/data/common/http_response_validator.dart';
import 'package:admin/data/models/user.dart';
import 'package:admin/screens/login/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class ILoginDataSource {
  Future<String> login({required String userName, required String password});
  Future<String> register(BuildContext context, String email, String lastname,
      String password, String surname, String username, String institution);
  Future<User> getUser(String token);
}

class LoginRemoteDataSource
    with HttpResponseValidator
    implements ILoginDataSource {
  final Dio httpClient;
  //final String token;

  LoginRemoteDataSource(
    this.httpClient,
  );

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
  Future<User> getUser(String token) async {
    print("getUser token: $token");
    httpClient.options.headers['content-Type'] = 'application/json';
    httpClient.options.headers['Authorization'] = 'Bearer $token';
    final response = await httpClient.get("api/UserProfile/GetUser");
    print("res: $response");
    validateResponse(response);
    User user = User.fromJson(response.data);
    return user;
  }

  @override
  Future<String> register(
      BuildContext context,
      String email,
      String lastname,
      String password,
      String surname,
      String username,
      String institution) async {
    int statusCode = 0;
    var formData = json.encode({
      "emailAddress": email,
      "lastname": lastname,
      "password": password,
      "surname": surname,
      "username": username,
      "institution": institution
    });
    String res = '';

    httpClient.options.headers['content-Type'] = 'application/json';

    final response = await httpClient
        .post(
      "api/Authenticate/register-user",
      data: formData,
      options: Options(
          followRedirects: false,
          validateStatus: (status) {
            statusCode = status!;
            return status < 500;
          }),
    )
        .then((value) {
      if (statusCode == 200 || statusCode == 201 || statusCode == 204) {
        res = value.data;
      } else if (statusCode == 400) {
        if (value.data.toString().contains('alredy exists!')) {
          throw (value.data.toString());
        } else
          throw (value.data[0]['description'] ?? value.data);
      } else if (statusCode == 401) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false);
      } else
        throw defaultError;
    });

    return res;
  }
}

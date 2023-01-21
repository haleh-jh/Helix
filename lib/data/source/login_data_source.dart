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
    int statusCode = 0;
    var formData = json.encode({"password": password, "userName": userName});
    httpClient.options.headers['content-Type'] = 'application/json';
    Response response = await httpClient.post(
      "api/Authenticate/login-user",
      data: formData,
      options: Options(
          followRedirects: false,
          validateStatus: (status) {
            statusCode = status!;
            return status < 500;
          }),
    );
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      return response.data['token'];
    } else {
      return validateResponse(response);
    }
  }

  @override
  Future<User> getUser(String token) async {
    int statusCode = 0;
    httpClient.options.headers['content-Type'] = 'application/json';
    httpClient.options.headers['Authorization'] = 'Bearer $token';
    Response response = await httpClient.get(
      "api/UserProfile/GetUser",
      options: Options(
          followRedirects: false,
          validateStatus: (status) {
            statusCode = status!;
            return status < 500;
          }),
    );
    if (statusCode == 200 || statusCode == 201 || statusCode == 204) {
      User user = User.fromJson(response.data);
      return user;
    } else {
      return validateResponse(response);
    }
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

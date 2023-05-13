import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:helix_with_clean_architecture/src/core/params/user_request_params.dart';
import 'package:helix_with_clean_architecture/src/data/datasources/remote/user_service/abstracts/user_api_service.dart';
import 'package:helix_with_clean_architecture/src/data/models/user_model.dart';
import 'package:universal_html/html.dart';

class UserApiServiceImpl implements UserApiService {
  final Dio _dio;

  UserApiServiceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<UserModel> getUser({required UserRequestParams params}) async {
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers['Authorization'] = 'Bearer ${params.token}';
    final response = await _dio.get('api/UserProfile/GetUser');
    print(response.statusCode);
    print(response);
    print(params.token);
    if (response.statusCode == HttpStatus.ok) {
      UserModel userModel = UserModel.fromJson(response.data);
      return userModel;
    }

    throw DioError(
        requestOptions: response.requestOptions,
        error: response.statusMessage,
        response: response.data,
        type: DioErrorType.response);
  }

  @override
  Future<String> login({required String data}) async {
    _dio.options.headers['content-Type'] = 'application/json';
    Response response = await _dio.post("api/Authenticate/login-user", data: data);
    if (response.statusCode == HttpStatus.ok) {
      return response.data['token'];
    }

    print(response.statusCode);
    print(response);

    throw DioError(
        requestOptions: response.requestOptions,
        error: response.statusMessage,
        response: response.data,
        type: DioErrorType.response);
  }

  @override
  Future<String> register(String data) async {
    _dio.options.headers['content-Type'] = 'application/json';
    final response =
        await _dio.post("api/Authenticate/register-user", data: data);
    if (response.statusCode == HttpStatus.ok) {
      return response.data['token'];
    }

    throw DioError(
        requestOptions: response.requestOptions,
        error: response.statusMessage,
        response: response.data,
        type: DioErrorType.response);
  }
}

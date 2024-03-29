import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:helix_with_clean_architecture/src/core/resources/concretes/data_failure.dart';
import 'package:helix_with_clean_architecture/src/core/resources/concretes/data_success.dart';
import 'package:helix_with_clean_architecture/src/data/datasources/remote/user_service/abstracts/user_api_service.dart';
import 'package:helix_with_clean_architecture/src/domain/entity/user.dart';
import 'package:helix_with_clean_architecture/src/core/resources/abstracts/data_state.dart';
import 'package:helix_with_clean_architecture/src/core/params/user_request_params.dart';
import 'package:helix_with_clean_architecture/src/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserApiService _userApiService;

  UserRepositoryImpl({required UserApiService userApiService})
      : _userApiService = userApiService;
  @override
  Future<DataState<User>> getUser(UserRequestParams params) async {
    try {
      final response = await _userApiService.getUser(params: params);
      return DataSuccess(response.toEntity());
    } on DioError catch (e) {
      return DataFailure('${e.type}', e.message);
    }
  }

  @override
  Future<DataState<String>> login({required String data}) async {
    try {
      final response = await _userApiService.login(data: data);
      return DataSuccess(response);
    } on DioError catch (e) {
      print("e4: ${e.message} , ${e.type}");
      return DataFailure('${e.type}', e.message);
    }
  }

  @override
  Future<DataState<String>> register(String data) async {
    try {
      final response = await _userApiService.register(data);
      return DataSuccess(response);
    } on DioError catch (e) {
      return DataFailure('${e.type}', e.message);
    }
  }
}

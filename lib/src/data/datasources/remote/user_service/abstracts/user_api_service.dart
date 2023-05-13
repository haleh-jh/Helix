import 'package:flutter/material.dart';
import 'package:helix_with_clean_architecture/src/core/params/user_request_params.dart';
import 'package:helix_with_clean_architecture/src/data/models/user_model.dart';

abstract class UserApiService {
  Future<UserModel> getUser({required UserRequestParams params});
  Future<String> login({required String data});
  Future<String> register(String data);
}

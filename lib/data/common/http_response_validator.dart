import 'package:admin/common/exception.dart';
import 'package:admin/constants.dart';
import 'package:admin/screens/login/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

mixin HttpResponseValidator {
  validateResponse(
    Response response,
  ) {
    print("response.statusCode: ${response.statusCode}");
    print("response.statusCode: ${response.data}");
    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 204) {
      return response;
    }
    //  else if (response.statusCode == 404) {
    //   throw Exception('404 ${response.data['message']}');
    // } else if (response.statusCode == 422) {
    //   throw Exception('${response.data['message']}');
    // }
    else if (response.statusCode == 500) {
      print(response.data);
      throw Exception(kServerError);
    } else {
      print("response.statusCode: ${response.data}");

      throw Exception('${response.data['message']}');
    }
  }
}

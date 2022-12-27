import 'package:admin/common/exception.dart';
import 'package:admin/constants.dart';
import 'package:admin/screens/login/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

mixin HttpResponseValidator {
  validateResponse(
    Response response,
  ) {
    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 204) {
      return response;
    }
     else if (response.statusCode == 401) {
      throw Exception('401');
    } 
    //   throw Exception('${response.data['message']}');
    // }
    else if (response.statusCode == 500) {
      throw Exception(kServerError);
    } else {
      throw Exception('${response.data['message']}');
    }
  }
}

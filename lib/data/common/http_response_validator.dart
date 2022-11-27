import 'package:admin/common/exception.dart';
import 'package:admin/screens/login/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


mixin HttpResponseValidator{
  validateResponse(Response response,){
    print("response.statusCode: ${response.statusCode}");
    if(response.statusCode!=200 && response.statusCode!=201 && response.statusCode!=204){
      throw AppException();
    } else if(response.statusCode == 401){
    
    }
  }
}
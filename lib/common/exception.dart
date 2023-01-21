import 'package:admin/screens/login/login_screen.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';

class AppException implements Exception{
  String message;

  AppException({this.message="خطای نامشخص"});


 static handleError(Object e){
          if(e is AppException){
           if (e.message.contains('401')) {
        Navigator.pushAndRemoveUntil(
            mainContext,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false);
      } 
      else throw AppException(message: e.message);
      } throw AppException(message: "An error has occurred");
  }

}
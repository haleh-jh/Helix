import 'package:admin/common/exception.dart';
import 'package:admin/constants.dart';
import 'package:dio/dio.dart';

mixin HttpResponseValidator {
  validateResponse(Response response) {
    if (!checkConnection()!) {
      throw Exception(kConnectionError);
    }
    if (response.statusCode == 404 || response.statusCode == 422) {
      throw AppException(message: response.data['message']);
    } else if (response.statusCode == 401) {
      throw AppException(message: '401');
    } else if (response.statusCode == 500) {
      throw AppException(message: kServerError);
    } else {
      throw AppException(message: kGeneralError);
    }
  }
}

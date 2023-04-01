import 'package:dio/dio.dart';
import 'package:helix_with_clean_architecture/src/core/params/user_request_params.dart';
import 'package:helix_with_clean_architecture/src/data/datasources/remote/user_service/abstracts/api_service.dart';
import 'package:helix_with_clean_architecture/src/domain/entity/info.dart';
import 'package:universal_html/html.dart';

class ApiServiceImpl implements ApiService {
  final Dio _dio;

  ApiServiceImpl({required Dio dio}) : _dio = dio;
  @override
  Future<List<dynamic>> getAll(
      {required UserRequestParams params, required String path}) async {
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers['Authorization'] = 'Bearer ${params.token}';
    final response = await _dio.get("api/$path");
    print(response);
    if (response.statusCode == HttpStatus.ok) {
      return response.data;
    }
    throw DioError(
        requestOptions: response.requestOptions,
        error: response.statusMessage,
        response: response.data,
        type: DioErrorType.response);
  }
}

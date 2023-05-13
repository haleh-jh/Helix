import 'package:dio/dio.dart';
import 'package:helix_with_clean_architecture/src/core/params/user_request_params.dart';
import 'package:helix_with_clean_architecture/src/data/datasources/remote/user_service/abstracts/api_service.dart';
import 'package:helix_with_clean_architecture/src/data/models/observation.dart';
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

  @override
  Future<List<ObservationsModel>> search(
      {required UserRequestParams params, data}) async {
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers['Authorization'] = 'Bearer ${params.token}';
    var formData = FormData.fromMap(data);

    print(data);
    Response response =
        await _dio.post('api/ObservationSubmissions/Search', data: formData);
    print(response);
    if (response.statusCode == HttpStatus.ok) {
      final list = <ObservationsModel>[];
      if (response.data != null) {
        (response.data as List).forEach((element) {
          if ((response.data as List).isNotEmpty) {
            list.add(ObservationsModel.fromJson(element));
          }
        });
      }
      return list;
    }
    throw DioError(
        requestOptions: response.requestOptions,
        error: response.statusMessage,
        response: response.data,
        type: DioErrorType.response);
  }

  @override
  Future<List<String>> getDownloadedFile(
      {required UserRequestParams params, required String id}) async {
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers['Authorization'] = 'Bearer ${params.token}';
    int statusCode = 0;
    final response =
        await _dio.get("api/ObservationSubmissions/GetFiles?Id=$id",
            options: Options(
              followRedirects: false,
              validateStatus: (status) {
                statusCode = status!;
                return statusCode < 600;
              },
            ));
            print(response);
    if (response.statusCode == HttpStatus.ok) {
      final list = <String>[];
      if (response.data != null) {
        (response.data as List).forEach((element) {
          list.add(element);
        });
      }
      return list;
    }
    throw DioError(
        requestOptions: response.requestOptions,
        error: response.statusMessage,
        response: response.data,
        type: DioErrorType.response);
  }
}

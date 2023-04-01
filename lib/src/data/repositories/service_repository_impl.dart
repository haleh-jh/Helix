import 'package:dio/dio.dart';
import 'package:helix_with_clean_architecture/src/core/resources/concretes/data_failure.dart';
import 'package:helix_with_clean_architecture/src/core/resources/concretes/data_success.dart';
import 'package:helix_with_clean_architecture/src/data/datasources/remote/user_service/abstracts/api_service.dart';
import 'package:helix_with_clean_architecture/src/domain/entity/info.dart';
import 'package:helix_with_clean_architecture/src/core/resources/abstracts/data_state.dart';
import 'package:helix_with_clean_architecture/src/core/params/user_request_params.dart';
import 'package:helix_with_clean_architecture/src/domain/repositories/service_repository.dart';

class ServiceRepositoryImpl implements ServiceRepository {
  final ApiService _apiService;

  ServiceRepositoryImpl({required ApiService apiService, })
      : _apiService = apiService;
  @override
  Future<DataState<List<dynamic>>> getAll(UserRequestParams params, String path) async {
    try {
      final response = await _apiService.getAll(params: params, path: path);
      return DataSuccess(response);
    } on DioError catch (e) {
      return DataFailure('${e.type}', e.message);
    }
  }
}

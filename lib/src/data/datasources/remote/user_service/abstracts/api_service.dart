import 'package:helix_with_clean_architecture/src/core/params/user_request_params.dart';
import 'package:helix_with_clean_architecture/src/domain/entity/info.dart';

abstract class ApiService{
  Future<List<dynamic>> getAll({required UserRequestParams params, required String path});
}
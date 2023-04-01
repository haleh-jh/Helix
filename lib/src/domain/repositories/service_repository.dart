import 'package:helix_with_clean_architecture/src/core/params/user_request_params.dart';
import 'package:helix_with_clean_architecture/src/core/resources/abstracts/data_state.dart';
import 'package:helix_with_clean_architecture/src/domain/entity/info.dart';

abstract class ServiceRepository{
  Future<DataState<List<dynamic>>> getAll(UserRequestParams params, String path);
}
import 'package:helix_with_clean_architecture/src/core/params/user_request_params.dart';
import 'package:helix_with_clean_architecture/src/data/models/observation.dart';
import 'package:helix_with_clean_architecture/src/domain/entity/info.dart';

abstract class ApiService {
  Future<List<dynamic>> getAll(
      {required UserRequestParams params, required String path});
  Future<List<ObservationsModel>> search(
      {required UserRequestParams params, var data});
  Future<List<String>> getDownloadedFile(
      {required UserRequestParams params, required String id});
}

import 'package:helix_with_clean_architecture/src/core/params/user_request_params.dart';
import 'package:helix_with_clean_architecture/src/core/resources/abstracts/data_state.dart';
import 'package:helix_with_clean_architecture/src/domain/entity/user.dart';

abstract class UserRepository {
  Future<DataState<User>> getUser(UserRequestParams params);
}
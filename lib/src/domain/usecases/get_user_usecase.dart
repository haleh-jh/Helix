import 'package:helix_with_clean_architecture/src/core/params/user_request_params.dart';
import 'package:helix_with_clean_architecture/src/core/resources/abstracts/data_state.dart';
import 'package:helix_with_clean_architecture/src/core/usecases/usecase_1_param.dart';
import 'package:helix_with_clean_architecture/src/domain/entity/user.dart';
import 'package:helix_with_clean_architecture/src/domain/repositories/user_repository.dart';

class GetUserUseCase implements UseCase<DataState<User>, UserRequestParams> {
  final UserRepository _userRepository;

  GetUserUseCase({required UserRepository userRepository})
      : _userRepository = userRepository;
  @override
  Future<DataState<User>> call({required UserRequestParams params}) => _userRepository.getUser(params);
}

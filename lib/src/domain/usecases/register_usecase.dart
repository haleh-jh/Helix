import '../../core/resources/abstracts/data_state.dart';
import '../../core/usecases/usecase_1_param.dart';
import '../repositories/user_repository.dart';

class RegisterUseCase implements UseCase<DataState<String>, String> {
  final UserRepository _userRepository;

  RegisterUseCase({required UserRepository userRepository})
      : _userRepository = userRepository;
  @override
  Future<DataState<String>> call({required String params}) => _userRepository.register(params);
}

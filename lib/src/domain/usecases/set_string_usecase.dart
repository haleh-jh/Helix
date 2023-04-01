import 'package:helix_with_clean_architecture/src/core/params/shared_pref_set_string_params.dart';
import 'package:helix_with_clean_architecture/src/core/resources/abstracts/data_state.dart';
import 'package:helix_with_clean_architecture/src/core/usecases/usecase_1_param.dart';
import 'package:helix_with_clean_architecture/src/domain/repositories/shared_pref_repository.dart';

class SetStringUseCase implements UseCase<DataState<void>, SharedPrefSetStringParams>{
  final SharedPrefRepository _sharedPrefRepository;

  SetStringUseCase({required SharedPrefRepository sharedPrefRepository}):
    _sharedPrefRepository = sharedPrefRepository;
  
  @override
  Future<DataState<void>> call({required SharedPrefSetStringParams params}) => _sharedPrefRepository.setString(params: params);

}
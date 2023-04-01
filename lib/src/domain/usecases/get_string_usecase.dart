import 'package:helix_with_clean_architecture/src/core/params/shared_pref_string_request_params.dart';
import 'package:helix_with_clean_architecture/src/core/resources/abstracts/data_state.dart';
import 'package:helix_with_clean_architecture/src/core/usecases/usecase_1_param.dart';
import 'package:helix_with_clean_architecture/src/domain/repositories/shared_pref_repository.dart';

class GetStringUseCase
    implements
        UseCase<DataState<String>, SharedPrefStringRequestParams> {
  final SharedPrefRepository _sharedPrefRepository;

  GetStringUseCase({required SharedPrefRepository sharedPrefRepository})
      : _sharedPrefRepository = sharedPrefRepository;

  @override
  Future<DataState<String>> call({
    required SharedPrefStringRequestParams params,
  })=> _sharedPrefRepository.getString(params: params);
     
}

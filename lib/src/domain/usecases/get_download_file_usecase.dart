import 'package:helix_with_clean_architecture/src/core/params/user_request_params.dart';
import 'package:helix_with_clean_architecture/src/core/usecases/usecase_2_param.dart';
import 'package:helix_with_clean_architecture/src/domain/repositories/service_repository.dart';

import '../../core/resources/abstracts/data_state.dart';

class GetDownloadFileUseCase
    implements UseCase<DataState<List<String>>, UserRequestParams, String> {
  final ServiceRepository _serviceRepository;

  GetDownloadFileUseCase({required ServiceRepository serviceRepository}): _serviceRepository = serviceRepository;

  @override
  Future<DataState<List<String>>> call(
      {required UserRequestParams params, required String data}) => _serviceRepository.getDownloadedFile(params: params, id: data);
}

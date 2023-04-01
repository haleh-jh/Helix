import 'package:helix_with_clean_architecture/src/core/params/user_request_params.dart';
import 'package:helix_with_clean_architecture/src/core/resources/abstracts/data_state.dart';
import 'package:helix_with_clean_architecture/src/core/usecases/usecase_2_param.dart';
import 'package:helix_with_clean_architecture/src/domain/repositories/service_repository.dart';

class GetAllUseCase implements UseCase<DataState<List<dynamic>>, UserRequestParams, String>{
  final ServiceRepository _serviceRepository;

  GetAllUseCase({required ServiceRepository serviceRepository}): _serviceRepository = serviceRepository;
  
  @override
  Future<DataState<List<dynamic>>> call({required UserRequestParams params, required String path}) => _serviceRepository.getAll(params, path);
  
}
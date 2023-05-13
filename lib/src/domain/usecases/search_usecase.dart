import 'package:helix_with_clean_architecture/src/data/models/observation.dart';
import 'package:helix_with_clean_architecture/src/domain/repositories/service_repository.dart';

import '../../core/params/user_request_params.dart';
import '../../core/resources/abstracts/data_state.dart';
import '../../core/usecases/usecase_2_param.dart';

class SearchUseCase
    implements UseCase<DataState<List<ObservationsModel>>, UserRequestParams, Map> {
  final ServiceRepository _serviceRepository;

  SearchUseCase({required ServiceRepository serviceRepository})
      : _serviceRepository = serviceRepository;
      
        @override
        Future<DataState<List<ObservationsModel>>> call({required UserRequestParams params, required Map data}) => _serviceRepository.search(params: params, data: data);
}

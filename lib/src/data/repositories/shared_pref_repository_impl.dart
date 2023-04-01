import 'package:helix_with_clean_architecture/src/core/resources/abstracts/data_state.dart';
import 'package:helix_with_clean_architecture/src/core/params/shared_pref_string_request_params.dart';
import 'package:helix_with_clean_architecture/src/core/params/shared_pref_set_string_params.dart';
import 'package:helix_with_clean_architecture/src/core/resources/concretes/data_failure.dart';
import 'package:helix_with_clean_architecture/src/core/resources/concretes/data_success.dart';
import 'package:helix_with_clean_architecture/src/data/datasources/local/shared_pref_service/abstracts/shared_pref_service.dart';
import 'package:helix_with_clean_architecture/src/domain/repositories/shared_pref_repository.dart';

class SharedPrefRepositoryImpl implements SharedPrefRepository{
  final SharedPrefService _sharedPrefService;

  SharedPrefRepositoryImpl({required SharedPrefService sharedPrefService}) : _sharedPrefService = sharedPrefService;

  @override
  Future<DataState<String>> getString({required SharedPrefStringRequestParams params}) async {
    try {
      final response = await _sharedPrefService.getString(params: params);
      return DataSuccess(response);
    } catch (e) {
      return DataFailure('$e', '');
    }
  }

  @override
  Future<DataState<void>> setString({required SharedPrefSetStringParams params}) async{
     try {
      final response = await _sharedPrefService.setString(params: params);

      return DataSuccess(response);
    } catch (e) {
      return Future.value(null);
      // return DataFailure(
      //   Fail(title: '$SharedPrefRepositoryImpl', message: '$e'),
      // );
    }
  }

}
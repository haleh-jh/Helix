import 'package:helix_with_clean_architecture/src/core/params/shared_pref_set_string_params.dart';
import 'package:helix_with_clean_architecture/src/core/params/shared_pref_string_request_params.dart';
import 'package:helix_with_clean_architecture/src/core/resources/abstracts/data_state.dart';

abstract class SharedPrefRepository{
  Future<DataState<String>> getString({required SharedPrefStringRequestParams params});
  Future<DataState<void>> setString({required SharedPrefSetStringParams params});
}
import 'package:helix_with_clean_architecture/src/core/params/shared_pref_set_string_params.dart';
import 'package:helix_with_clean_architecture/src/core/params/shared_pref_string_request_params.dart';

abstract class SharedPrefService{
  Future<String> getString({required SharedPrefStringRequestParams params});
  Future<void> setString({required SharedPrefSetStringParams params});
}
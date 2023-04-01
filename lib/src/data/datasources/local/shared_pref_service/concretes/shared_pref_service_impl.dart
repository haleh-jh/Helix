import 'package:helix_with_clean_architecture/src/core/params/shared_pref_string_request_params.dart';
import 'package:helix_with_clean_architecture/src/core/params/shared_pref_set_string_params.dart';
import 'package:helix_with_clean_architecture/src/core/utils/constants/exceptions.dart';
import 'package:helix_with_clean_architecture/src/data/datasources/local/shared_pref_service/abstracts/shared_pref_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefServiceImpl implements SharedPrefService {
  final SharedPreferences _preferences;

  SharedPrefServiceImpl({required SharedPreferences preferences})
      : _preferences = preferences;

  @override
  Future<String> getString({required SharedPrefStringRequestParams params}) async {
    final value = _preferences.getString(params.key);
    if(value == null) throw Exception(kSharedPrefNoValueException);
    return value;
  }

  @override
  Future<void> setString({required SharedPrefSetStringParams params}) async{
   final isSuccess = await _preferences.setString(params.key, params.value);
   if(!isSuccess) throw Exception(kSharedPrefCouldNotSetValue);
  }
}

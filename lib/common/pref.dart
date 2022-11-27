
import 'package:admin/data/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
class PreferenceUtils{

  static SharedPreferences? _prefs;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences?> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  static reload(){
    _prefs!.reload();
  }
  
  //sets
  static Future<bool> setBool(String key, bool value) async =>
      await _prefs!.setBool(key, value);

  static Future<bool> setDouble(String key, double value) async =>
      await _prefs!.setDouble(key, value);

  static Future<bool> setInt(String key, int value) async =>
      await _prefs!.setInt(key, value);

  static Future<bool> setString(String key, String value) async =>
      await _prefs!.setString(key, value);

  static Future<bool> setStringList(String key, List<String> value) async =>
      await _prefs!.setStringList(key, value);

  //gets
  static bool? getBool(String key) => _prefs!.getBool(key);

  static double? getDouble(String key) => _prefs!.getDouble(key);

  static int? getInt(String key) => _prefs!.getInt(key);

  static String? getString(String key) => _prefs!.getString(key) ?? '';

  static List<String>? getStringList(String key) => _prefs!.getStringList(key);

  //deletes..
  static Future<bool> remove(String key) async => await _prefs!.remove(key);

  static Future<bool> clear() async => await _prefs!.clear();


 static saveUserData(User user) async {
   await setString("id", user.id);
   await setString("userName", user.userName);
   await setString("email", user.email);
   await setString("type", user.type);
   await setString("surname", user.surname);
   await setString("lastName", user.lastName);
   await setString("institution", user.institution);
   await setString("phoneNumber", user.phoneNumber);
   await setBool("emailConfirmed", user.emailConfirmed);
   await setBool("phoneNumberConfirmed", user.phoneNumberConfirmed);
  }
}
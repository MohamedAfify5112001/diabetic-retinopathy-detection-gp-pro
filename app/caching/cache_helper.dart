import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences _sharedPreferences;

  static initPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putValue(
      {required String key, required String val}) async {
    return await _sharedPreferences.setString(key, val);
  }

  static String getValue({required String key}) {
    return _sharedPreferences.getString(key) ?? "";
  }

  static Future removeValue({required String key}) async =>
      await _sharedPreferences.remove(key);
}

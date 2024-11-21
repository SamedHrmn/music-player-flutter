import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  AppSharedPreferences._() {
    initPref();
  }
  static late final SharedPreferences _prefsInstance;

  static Future<void> initPref() async {
    _prefsInstance = await SharedPreferences.getInstance();
  }

  String getString(String key, [String? defValue]) {
    return _prefsInstance.getString(key) ?? defValue ?? '';
  }

  Future<void> setString(String key, String value) async {
    await _prefsInstance.setString(key, value);
  }
}

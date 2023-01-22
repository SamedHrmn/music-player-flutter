import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  static final AppSharedPreferences _instance = AppSharedPreferences._internal();
  SharedPreferences? _prefsInstance;
  static AppSharedPreferences get instance => _instance;

  factory AppSharedPreferences() {
    return _instance;
  }

  AppSharedPreferences._internal() {
    if (_prefsInstance == null) {
      SharedPreferences.getInstance().then((value) {
        _prefsInstance = value;
      });
    }
  }

  static Future<void> initPref() async {
    instance._prefsInstance ??= await SharedPreferences.getInstance();
  }

  String getString(String key, [String? defValue]) {
    return _prefsInstance?.getString(key) ?? defValue ?? "";
  }

  Future<void> setString(String key, String value) async {
    await _prefsInstance?.setString(key, value);
  }
}

import 'package:shared_preferences/shared_preferences.dart';

abstract class AppLocalDatabase {
  T? getValue<T>(String key, [String? defaultValue]);
  Future<void> putValue<T>(String key, T data);
}

class AppSharedPreferences implements AppLocalDatabase {
  const AppSharedPreferences(this._prefsInstance);
  final SharedPreferences _prefsInstance;

  @override
  T? getValue<T>(String key, [String? defaultValue]) {
    switch (T) {
      case String:
        return (_prefsInstance.getString(key) ?? defaultValue) as T;
      case int:
        return (_prefsInstance.getInt(key) ?? defaultValue) as T;
      case bool:
        return (_prefsInstance.getBool(key) ?? defaultValue) as T;
      case double:
        return (_prefsInstance.getDouble(key) ?? defaultValue) as T;
      default:
        throw Exception('Unsupported type $T');
    }
  }

  @override
  Future<void> putValue<T>(String key, T data) async {
    switch (data) {
      case String:
        await _prefsInstance.setString(key, data as String);
      case int:
        await _prefsInstance.setInt(key, data as int);
      case bool:
        await _prefsInstance.setBool(key, data as bool);
      case double:
        await _prefsInstance.setDouble(key, data as double);
      default:
        throw Exception('Unsupported type $T');
    }
  }
}

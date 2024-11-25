import 'dart:developer';

class AppLogger {
  const AppLogger._();

  static void debugLog({required String msg, Object? error}) {
    log(msg, error: error);
  }
}

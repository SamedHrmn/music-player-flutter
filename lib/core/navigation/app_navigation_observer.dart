import 'package:flutter/material.dart';
import 'package:music_player/core/utils/app_logger.dart';

class AppNavigatiorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _logRoute(route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null) {
      _logRoute(newRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute != null) {
      _logRoute(previousRoute);
    }
  }

  void _logRoute(Route<dynamic> route) {
    if (route.settings.name != null) {
      AppLogger.debugLog(msg: 'Current page: ${route.settings.name}');
    } else {
      AppLogger.debugLog(msg: 'Current page: ${route.runtimeType}');
    }
  }
}

import 'package:flutter/material.dart';
import 'package:music_player/core/enum/route_enum.dart';

class AppNavigationManager {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Push a new route onto the stack
  void navigateTo(RouteEnum route, {Object? arguments}) {
    navigatorKey.currentState?.pushNamed(
      route.path,
      arguments: arguments,
    );
  }

  void navigateToPopBackAll(RouteEnum route, {Object? arguments}) {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      route.path,
      (route) => route.settings.name == RouteEnum.initial.path,
      arguments: arguments,
    );
  }

  // Replace the current route with a new one
  void replaceWith(BuildContext context, RouteEnum route) {
    navigatorKey.currentState?.pushReplacementNamed(
      route.path,
    );
  }

  // Pop the current route off the stack
  void goBack(BuildContext context) {
    if (navigatorKey.currentState?.canPop() ?? false) {
      navigatorKey.currentState?.pop();
    }
  }

  // Pop to the first route in the stack
  void goToRoot(BuildContext context) {
    navigatorKey.currentState?.popUntil((route) => route.isFirst);
  }
}

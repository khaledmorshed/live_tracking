import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Navigation Service Without Context

/// For NavigationService
class NavigationService {

  static double latitude = 0;
  static double longitude = 0;

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  dynamic routeTo(dynamic route, {dynamic arguments}) {
    return navigatorKey.currentState?.pushNamed(route, arguments: arguments);
  }

  dynamic goBack() {
    return navigatorKey.currentState?.pop();
  }
}
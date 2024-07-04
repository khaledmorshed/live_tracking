import 'dart:async';

import 'package:background_locator_2/location_dto.dart';

import 'location_service_repository.dart';

@pragma('vm:entry-point')
class LocationCallbackHandler {
  @pragma('vm:entry-point')
  static Future<void> initCallback(Map<dynamic, dynamic> params) async {
    print("initCallback...");
    LocationServiceRepository myLocationCallbackRepository =
    LocationServiceRepository();
    await myLocationCallbackRepository.init(params);
  }

  @pragma('vm:entry-point')
  static Future<void> disposeCallback() async {
    print("disposeCallback...");
    LocationServiceRepository myLocationCallbackRepository =
    LocationServiceRepository();
    await myLocationCallbackRepository.dispose();
  }

  @pragma('vm:entry-point')
  static Future<void> callback(LocationDto locationDto) async {
    LocationServiceRepository myLocationCallbackRepository =
    LocationServiceRepository();
    await myLocationCallbackRepository.callback(locationDto);
  }

  @pragma('vm:entry-point')
  static Future<void> notificationCallback() async {
    print('***notificationCallback');
  }
}
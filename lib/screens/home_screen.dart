import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';
import 'package:background_locator_2/background_locator.dart';
import 'package:background_locator_2/settings/android_settings.dart';
import 'package:background_locator_2/settings/ios_settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:live_tracking_second/screens/global_provider.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'local_notification_service.dart';
import 'package:flutter/cupertino.dart';

import 'location_callback_handler.dart';
import 'navigation_service.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {

  Location location = Location();
  double latitude = 0;
  double longitude = 0;
  late GlobalProvider provider;

  static const String _isolateName = "LocatorIsolate";
  ReceivePort port = ReceivePort();

  @override
  void initState() {
    super.initState();
    //startLocationService();
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
    port.listen((dynamic data) {
      // do something with data
    //  subscribeToLocationChanges();
     // startLocationService();
    });
    provider = Provider.of<GlobalProvider>(context, listen: false);
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    await BackgroundLocator.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home screen"),
      ),
      body: Consumer<GlobalProvider>(
        builder: (context, provider, _) {
          return Column(
            children: [
              SizedBox(height: 100,),
              Center(child: Text("latitude=${latitude}   longitude=${longitude}"),),

              // ElevatedButton(onPressed: () {
              //   launchUrl(Uri.parse("https://www.google.com/maps?q=$latitude,$longitude"));
              // }, child: Text("show location"),),
              //
              ElevatedButton(onPressed: () async {
                //subscribeToLocationChanges();
                startLocationService();
              }, child: Text("change location"),),

              ElevatedButton(onPressed: () async {
          BackgroundLocator.unRegisterLocationUpdate();
              }, child: Text("unregistered"),),

            ],
          );
        }
      ),
    );
  }

  void subscribeToLocationChanges() async {
    location.enableBackgroundMode(enable: true);

    bool _bgModeEnabled = await location.isBackgroundModeEnabled();
    print("_bgModeEnabled...$_bgModeEnabled");
    enableBackgroundMode();
    location.onLocationChanged.listen((LocationData currentLocation) {
      print("location changed: lat....${currentLocation.latitude}....long...${currentLocation.longitude}");
      setState(() {
        latitude = currentLocation.latitude!;
        longitude = currentLocation.longitude!;
      });
      provider.latitude = currentLocation.latitude!;
      provider.longitude = currentLocation.longitude!;
      provider.notifyListeners();

    });
  }

  Future<bool> enableBackgroundMode() async {
    bool _bgModeEnabled = await location.isBackgroundModeEnabled();
    print("_bgModeEnabled...$_bgModeEnabled");
    if (_bgModeEnabled) {
      return true;
    } else {
      try {
        await location.enableBackgroundMode();
      } catch (e) {
        debugPrint(e.toString());
      }
      try {
        _bgModeEnabled = await location.enableBackgroundMode();
      } catch (e) {
        debugPrint(e.toString());
      }
      print("_bgModeEnabled.2..$_bgModeEnabled");
      print(_bgModeEnabled); // True!
      return _bgModeEnabled;
    }
  }


  void startLocationService()async{
    location.enableBackgroundMode(enable: true);
    bool _bgModeEnabled = await location.isBackgroundModeEnabled();
    print("_bgModeEnabled...$_bgModeEnabled");
    enableBackgroundMode();
    location.onLocationChanged.listen((LocationData currentLocation) {
      print("location changed: lat....${currentLocation.latitude}....long...${currentLocation.longitude}");
      setState(() {
        latitude = currentLocation.latitude!;
        longitude = currentLocation.longitude!;
      });

      // NavigationService.latitude = currentLocation.latitude!;
      // provider.longitude = currentLocation.longitude!;
      // provider.notifyListeners();

    });

    BackgroundLocator.registerLocationUpdate(LocationCallbackHandler.callback,
        initCallback: LocationCallbackHandler.initCallback,
        initDataCallback: {"data": 'data33'},
        disposeCallback: LocationCallbackHandler.disposeCallback,
        autoStop: false,
        iosSettings: IOSSettings(
            //accuracy: LocationAccuracy.navigation, distanceFilter: 0
        ),
        androidSettings: AndroidSettings(
            //accuracy: const LocationAccuracy.NAVIGATION,
            interval: 5,
            distanceFilter: 0,
            androidNotificationSettings: AndroidNotificationSettings(
                notificationChannelName: 'Location tracking',
                notificationTitle: 'Start Location Tracking',
                notificationMsg: 'Track location in background',
                notificationBigMsg:
                'Background location is on to keep the app up-tp-date with your location. This is required for main features to work properly when the app is not running.',
                notificationIcon: '',
                notificationIconColor: Colors.grey,
                notificationTapCallback:
                LocationCallbackHandler.notificationCallback)));
  }
}

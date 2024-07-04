import 'package:flutter/material.dart';
import 'package:live_tracking_second/screens/global_provider.dart';
import 'package:live_tracking_second/screens/home_screen.dart';
import 'package:live_tracking_second/screens/local_notification_service.dart';
import 'package:live_tracking_second/screens/navigation_service.dart';
import 'package:live_tracking_second/screens/splash_screen.dart';
import 'package:provider/provider.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();


void main() {
  runApp(const MyApp());

  final providerList =  [

    ChangeNotifierProvider(create: (context) => GlobalProvider()),

  ];


  LocalNotificationService().initNotification();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: providerList,
    child: const MyApp(),
  ),);

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      navigatorKey: NavigationService.navigatorKey,
      scaffoldMessengerKey: scaffoldMessengerKey,
      home: const SplashScreen(),
    );
  }
}



import 'dart:async';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String route = "/SplashScreen";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  startTimer() {
    Timer(const Duration(seconds: 2), () async {
      Map<Permission, PermissionStatus> statuses = await [Permission.notification, Permission.storage, Permission.location].request();
      // if(statuses[Permission.camera] == PermissionStatus.granted && statuses[Permission.location] == PermissionStatus.granted){
      // }else{
      //   print("ererun....");
      //   return;
      // }
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );

    });
  }


  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(),
    );
  }
}

import 'package:call_recording/home1.dart';
import 'package:call_recording/query.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:call_detector/call_detector.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:system_alert_window/system_alert_window.dart';


import 'call/call_detection.dart';
import 'database_helper.dart';


  void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await initializeService();
  // await FlutterBackgroundService().startService();
  // // Starting service in foreground mode
  // FlutterBackgroundService().invoke("setAsForeground");
  // Future.delayed(const Duration(seconds: 7), () {
  //   // Method to pass api data to background service as they use isolates so it is not possible to directly pass data in that function
  //   FlutterBackgroundService().invoke("listenIncoming");
  // });
  // startBgCaller();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override


  // @override
  // void initState() {
  //   super.initState();
  //   getPermission();
  //   SystemAlertWindow.registerOnClickListener(callBack);
  // }

  // getPermission() async {
  //   await SystemAlertWindow.checkPermissions;
  //   }


  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQFlite Demo',
      home: home1(),
    );
  }
}


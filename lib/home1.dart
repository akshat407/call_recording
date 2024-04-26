import 'package:call_recording/query.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:call_detector/call_detector.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:system_alert_window/system_alert_window.dart';


import 'call/call_detection.dart';
import 'database_helper.dart';


class home1 extends StatefulWidget {
  const home1({super.key});

  @override
  State<home1> createState() => _home1State();
}

class _home1State extends State<home1> {
   String _name = '';
   @override
  void initState() {
    super.initState();
    
    getPermission();
  }

  getPermission() async {
    await SystemAlertWindow.checkPermissions;
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: (){
             Navigator.of(context).push(MaterialPageRoute(builder: (context) => Query()));
            }, 
            child: Text("Query")),
            ElevatedButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Example()));
              SystemAlertWindow.showSystemWindow(
                gravity: SystemWindowGravity.CENTER,
                notificationTitle: "bghsjdbs" ,prefMode: SystemWindowPrefMode.OVERLAY,
                notificationBody: "dhgusd"
                
              );
            }, 
            child: Text("call detection")),
              ElevatedButton(
              onPressed: () async {
                String phoneNumber = {status.number}.toString();
                String name = await checkPhoneNumber(phoneNumber);
                setState(() {
                  _name = name;
                });
              },
              child: Text('Check'),
            ),
        ],
      ),
      ),
    );
  }
  Future<String> checkPhoneNumber(String phoneNumber) async {
    // Get the path to the database file
    String path = join(await getDatabasesPath(), 'contacts.db');

    // Open the database
    Database database = await openDatabase(path, version: 2);

    // Query the database
    List<Map> result = await database.rawQuery(
        'SELECT columnName FROM contacts WHERE columnPhone = ?',
        [status.number]);

    // Close the database
    await database.close();

    // Return the name if found, otherwise an empty string
    return result.isNotEmpty ? result[0]['columnName'] : '';
  }
}
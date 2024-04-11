import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:call_detector/call_detector.dart';
import 'package:flutter_background_service/flutter_background_service.dart';


import 'call/call_detection.dart';
import 'database_helper.dart';


class Query extends StatefulWidget {
  @override
  _QueryState createState() => _QueryState();

  static checkPhoneNumber(String phoneNumber) {}
}

class _QueryState extends State<Query> {
  final dbHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> _contacts = [];

  @override
  void initState() {
    super.initState();
    _insertDummyData(); // Insert dummy data when the app starts
    _query(); // Query data from the database
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQFlite Demo'),
      ),
      body: Center(
        child: _contacts.isEmpty
            ? const CircularProgressIndicator() // Show loading indicator while data is being fetched
            : ListView.builder(
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  final contact = _contacts[index];
                  return ListTile(
                    title: Text(contact[DatabaseHelper.columnName]),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text(contact[DatabaseHelper.columnPhone]),
                      Text(contact[DatabaseHelper.columnEmail]),
                    ],),
                    trailing: IconButton(
                      onPressed: (){
                        _deleteContact(contact[DatabaseHelper.columnId]);
                      }, 
                      icon: const Icon(Icons.delete),
                      )
                  
                  );
                },
              ),
      ),
      
      );
 
      
  }

  // Method to insert dummy data into the database
  void _insertDummyData() async {
    Map<String, dynamic> row1 = {
      DatabaseHelper.columnName: "Akshat Srivastava",
      DatabaseHelper.columnPhone: "+918700732750",
      // DatabaseHelper.columnWhatsappPhone: "+918700732750",
      DatabaseHelper.columnEmail: "akshat@gmail.com"
    };

    Map<String, dynamic> row2 = {
      DatabaseHelper.columnName: "Satwik Gupta",
      DatabaseHelper.columnPhone: "+91991453630",
      DatabaseHelper.columnEmail: "satwik@gmail.com"
    };

    await dbHelper.insert(row1);
    await dbHelper.insert(row2);
  }

  // Method to query data from the database
  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    setState(() {
      _contacts = allRows;
    });
  }
  void _deleteContact(int id) async {
    final rowsDeleted = await dbHelper.delete(id);
    print('Deleted $rowsDeleted row(s): ID $id');
    _query(); // Refresh the list after deletion
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
    return result.isNotEmpty ? result[0]['name'] : '';
  }
}

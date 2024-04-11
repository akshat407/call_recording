import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'database_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQFlite Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        title: Text('SQFlite Demo'),
      ),
      body: Center(
        child: _contacts.isEmpty
            ? CircularProgressIndicator() // Show loading indicator while data is being fetched
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
                      icon: Icon(Icons.delete),
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
}

import 'package:flutter/material.dart';
import 'package:local_db_app/database_manager.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {


    DatabaseManager databaseManager = DatabaseManager.instance;
    databaseManager.database;

    return const Scaffold(
      body: Center(child: Text("data"),),
    );
  }
}


import 'package:flutter/material.dart';
import 'screens/task1_screen.dart';
import 'screens/task2_screen.dart';
import 'screens/task3_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Калькулятори'),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: "Завдання 1"),
              Tab(text: "Завдання 2"),
              Tab(text: "Завдання 3"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Task1Screen(),
            Task2Screen(),
            Task3Screen(),
          ],
        ),
      ),
    );
  }
}

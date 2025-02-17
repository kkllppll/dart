import 'package:flutter/material.dart';
import 'task1_screen.dart';
import 'task2_screen.dart';
import 'task3_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [Task1Screen(), Task2Screen(), Task3Screen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Калькулятор")),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.looks_one), label: "ШР1/ШР2/ШР3"),
          BottomNavigationBarItem(icon: Icon(Icons.looks_two), label: "ЕП"),
          BottomNavigationBarItem(icon: Icon(Icons.looks_3), label: "Весь цех"),
        ],
      ),
    );
  }
}

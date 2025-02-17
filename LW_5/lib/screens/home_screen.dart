import 'package:flutter/material.dart';
import 'task1_screen.dart';
import 'task2_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [Task1Screen(), Task2Screen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Калькулятор ")),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: "Завдання 1"),
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: "Завдання 2"),
        ],
      ),
    );
  }
}

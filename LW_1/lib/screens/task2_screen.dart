import 'package:flutter/material.dart';
import '../models/mazut_calculator.dart';
import '../widgets/input_field.dart';
import '../widgets/result_text.dart';

class Task2Screen extends StatefulWidget {
  @override
  _Task2ScreenState createState() => _Task2ScreenState();
}

class _Task2ScreenState extends State<Task2Screen> {
  final _calculator = MazutCalculator();
  final _controllers = List.generate(8, (_) => TextEditingController());
  String _result = '';

  void _calculate() {
    try {
      _calculator.inputFuelComponents(
        double.tryParse(_controllers[0].text) ?? 0,
        double.tryParse(_controllers[1].text) ?? 0,
        double.tryParse(_controllers[2].text) ?? 0,
        double.tryParse(_controllers[3].text) ?? 0,
        double.tryParse(_controllers[4].text) ?? 0,
        double.tryParse(_controllers[5].text) ?? 0,
        double.tryParse(_controllers[6].text) ?? 0,
        double.tryParse(_controllers[7].text) ?? 0,
      );

      final composition = _calculator.combToWorking();
      final lowerHeating = _calculator.calculateWorkingHeatingValue();

      setState(() {
        _result = '''
Елементарний склад:
${composition["composition"].entries.map((e) => "${e.key}: ${e.value.toStringAsFixed(2)}").join("\n")}

Нижча теплота згоряння робочої маси: ${lowerHeating.toStringAsFixed(2)}
''';
      });
    } catch (e) {
      setState(() {
        _result = 'Помилка: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Завдання 2"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputField(controller: _controllers[0], hint: "Введіть CP, %"),
              InputField(controller: _controllers[1], hint: "Введіть HP, %"),
              InputField(controller: _controllers[2], hint: "Введіть OP, %"),
              InputField(controller: _controllers[3], hint: "Введіть SP, %"),
              InputField(controller: _controllers[4], hint: "Введіть LH_Q, %"),
              InputField(controller: _controllers[5], hint: "Введіть WP, %"),
              InputField(controller: _controllers[6], hint: "Введіть AP, %"),
              InputField(controller: _controllers[7], hint: "Введіть VP, %"),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _calculate,
                  child: Text("Розрахувати"),
                ),
              ),
              SizedBox(height: 20),
              ResultText(text: _result),
            ],
          ),
        ),
      ),
    );
  }
}

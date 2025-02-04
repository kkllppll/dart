import 'package:flutter/material.dart';
import '../models/fuel_calculator.dart';
import '../widgets/input_field.dart';
import '../widgets/result_text.dart';

class Task1Screen extends StatefulWidget {
  @override
  _Task1ScreenState createState() => _Task1ScreenState();
}

class _Task1ScreenState extends State<Task1Screen> {
  final _calculator = FuelCalculator();
  final _controllers = List.generate(7, (_) => TextEditingController());
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
      );

      final workingQ = _calculator.calculateLowerHeatingValueWorkingMass();
      final dry = _calculator.coeffWorkingToDry();
      final comb = _calculator.coeffWorkingToComb();
      final dryQ = _calculator.calculateLowerHeatingValueDryMass(workingQ);
      final combQ = _calculator.calculateLowerHeatingValueCombustibleMass(workingQ);

      setState(() {
        _result = '''
Коефіцієнт сухої маси: ${dry["coefficient"].toStringAsFixed(2)}
Склад сухої маси:
${dry["composition"].entries.map((e) => "${e.key}: ${e.value.toStringAsFixed(2)}").join("\n")}

Коефіцієнт горючої маси: ${comb["coefficient"].toStringAsFixed(2)}
Склад горючої маси:
${comb["composition"].entries.map((e) => "${e.key}: ${e.value.toStringAsFixed(2)}").join("\n")}

Теплота згоряння робочої маси: ${workingQ.toStringAsFixed(2)}
Теплота згоряння сухої маси: ${dryQ.toStringAsFixed(2)}
Теплота згоряння горючої маси: ${combQ.toStringAsFixed(2)}
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
        title: Text("Завдання 1"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputField(controller: _controllers[0], hint: "Введіть HP, %"),
              InputField(controller: _controllers[1], hint: "Введіть CP, %"),
              InputField(controller: _controllers[2], hint: "Введіть SP, %"),
              InputField(controller: _controllers[3], hint: "Введіть NP, %"),
              InputField(controller: _controllers[4], hint: "Введіть OP, %"),
              InputField(controller: _controllers[5], hint: "Введіть WP, %"),
              InputField(controller: _controllers[6], hint: "Введіть AP, %"),
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

import 'package:flutter/material.dart';
import '../models/fuel_calculator.dart';
import '../widgets/input_field.dart';
import '../widgets/result_text.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _calculator = FuelCalculator();
  final _controllers = List.generate(7, (_) => TextEditingController());
  String _result = '';

  void _calculate() {
    try {
      _calculator.inputParameters(
        double.tryParse(_controllers[0].text) ?? 0.0,
        double.tryParse(_controllers[1].text) ?? 0.0,
        double.tryParse(_controllers[2].text) ?? 0.0,
        double.tryParse(_controllers[3].text) ?? 0.0,
        double.tryParse(_controllers[4].text) ?? 0.0,
        double.tryParse(_controllers[5].text) ?? 0.0,
        double.tryParse(_controllers[6].text) ?? 0.0,
      );

      double emissionFactor = _calculator.calculateEmissionFactor();
      double totalEmission = _calculator.calculateTotalEmission();

      setState(() {
        _result = '''
Показник емісії: ${emissionFactor.toStringAsFixed(2)} г/ГДж
Валовий викид: ${totalEmission.toStringAsFixed(2)} т
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
      appBar: AppBar(title: Text("Розрахунок викидів"), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputField(controller: _controllers[0], hint: "Нижча теплота згоряння Q (МДж/кг)"),
              InputField(controller: _controllers[1], hint: "Частка леткої золи aвин"),
              InputField(controller: _controllers[2], hint: "Масова частка золи Ar (%)"),
              InputField(controller: _controllers[3], hint: "Гвин (%)"),
              InputField(controller: _controllers[4], hint: "Ефективність золовловлення ηзу"),
              InputField(controller: _controllers[5], hint: "Ктв"),
              InputField(controller: _controllers[6], hint: "Витрати палива B (т)"),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(onPressed: _calculate, child: Text("Розрахувати")),
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

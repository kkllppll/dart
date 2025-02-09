import 'package:flutter/material.dart';
import '../models/calculator.dart';
import '../widgets/result_display.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController powerController = TextEditingController();
  final TextEditingController deviationController = TextEditingController();
  final TextEditingController lowerDeviationController = TextEditingController();
  final TextEditingController costController = TextEditingController();

  Map<String, double>? results;

  void calculate() {
    try {
      double power = double.parse(powerController.text);
      double deviation = double.parse(deviationController.text);
      double lowerDeviation = double.parse(lowerDeviationController.text);
      double cost = double.parse(costController.text);

      Calculator calculator = Calculator();
      calculator.inputParameters(power, deviation, lowerDeviation, cost);
      setState(() {
        results = calculator.calculate();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Помилка введення даних: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Калькулятор розрахунку прибутку'),
          centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInputField("Середня потужність (Pс), МВт:", powerController),
              _buildInputField("Стандартне відхилення (σP), МВт:", deviationController),
              _buildInputField("Зменшена похибка (σP), МВт:", lowerDeviationController),
              _buildInputField("Тариф на енергію (В), грн/кВт·год:", costController),
              SizedBox(height: 20),
              Center(
                  child: ElevatedButton(
                    onPressed: calculate,
                    child: Text("Розрахувати"),
                  ),
              ),
              SizedBox(height: 20),
              if (results != null) ResultDisplay(results: results!)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Введіть значення',
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}

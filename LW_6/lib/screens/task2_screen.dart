import 'package:flutter/material.dart';
import '../models/calculations2.dart';
import '../widgets/input_group2.dart';

class Task2Screen extends StatefulWidget {
  @override
  _Task2ScreenState createState() => _Task2ScreenState();
}

class _Task2ScreenState extends State<Task2Screen> {
  final List<InputGroup2> _groups = [];
  String resultText = "";

  void _addGroup() {
    setState(() {
      _groups.add(InputGroup2(
        onRemove: () => setState(() => _groups.removeLast()),
      ));
    });
  }

  void _calculateResults() {
    List<Map<String, double>> groupsData = _groups.map((group) {
      return {
        'quantity': double.tryParse(group.quantityController.text) ?? 0,
        'power': double.tryParse(group.powerController.text) ?? 0,
        'usageCoeff': double.tryParse(group.usageCoeffController.text) ?? 0,
        'tgPhi': double.tryParse(group.tgPhiController.text) ?? 0,
        'voltage': double.tryParse(group.voltageController.text) ?? 0,
      };
    }).toList();

    var result = Calculations2.calculate(groupsData);
    if (result.containsKey('error')) {
      setState(() => resultText = "Напруга не задана або рівна нулю для всіх груп.");
      return;
    }

    setState(() {
      resultText = """
        n * Ph = ${result['nPh']!.toStringAsFixed(2)}
        N * Ph * Kv: ${result['nPhKv']!.toStringAsFixed(2)}
        Реактивне навантаження (Qp): ${result['Qp']!.toStringAsFixed(2)} кВАр
        Ефективна кількість ЕП (n_e): ${result['powerSquaredSum']!.toStringAsFixed(2)}
        Розрахунковий груповий струм (Ip): ${result['Ip']!.toStringAsFixed(2)} А
      """;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ЕП")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(onPressed: _addGroup, child: Text("Додати групу")),
            Column(children: _groups),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _calculateResults, child: Text("Розрахувати")),
            SizedBox(height: 20),
            Text(resultText, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

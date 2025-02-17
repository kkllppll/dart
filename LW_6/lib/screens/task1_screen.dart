import 'package:flutter/material.dart';
import '../models/calculations1.dart';
import '../widgets/input_group1.dart';

class Task1Screen extends StatefulWidget {
  @override
  _Task1ScreenState createState() => _Task1ScreenState();
}

class _Task1ScreenState extends State<Task1Screen> {
  final List<InputGroup1> _groups = [];
  String resultText = "";

  void _addGroup() {
    setState(() {
      _groups.add(InputGroup1(
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

    var result = Calculations1.calculate(groupsData);
    if (result.containsKey('error')) {
      setState(() => resultText = "Напруга не задана або рівна нулю для всіх груп.");
      return;
    }

    setState(() {
      resultText = """
        Kv = ${result['Kv']!.toStringAsFixed(4)}
        Ефективна кількість ЕП (n_e): ${result['Ne']!.toStringAsFixed(2)}
        Розрахунковий коефіцієнт Kp: ${result['Kp']!.toStringAsFixed(2)}
        Розрахункове активне навантаження (Pp): ${result['Pp']!.toStringAsFixed(2)} кВт
        Реактивне навантаження (Qp): ${result['Qp']!.toStringAsFixed(2)} кВАр
        Повна потужність (Sp): ${result['Sp']!.toStringAsFixed(2)} кВА
        Розрахунковий груповий струм (Ip): ${result['Ip']!.toStringAsFixed(2)} А
        Кількість ЕП (n): ${result['quantityNum']!.toInt()}
        n * Ph: ${result['nPh']!.toStringAsFixed(2)}
        n * Ph * Kv: ${result['nPhKv']!.toStringAsFixed(2)}
        n * Ph^2: ${result['nPh2']!.toStringAsFixed(2)}
      """;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ШР1/ШР2/ШР3")),
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

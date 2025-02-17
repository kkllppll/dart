import 'package:flutter/material.dart';
import '../models/calculations3.dart';

class Task3Screen extends StatefulWidget {
  @override
  _Task3ScreenState createState() => _Task3ScreenState();
}

class _Task3ScreenState extends State<Task3Screen> {
  final _quantityController = TextEditingController();
  final _phiController = TextEditingController();
  final _nPhKvController = TextEditingController();
  final _nPnKvtgController = TextEditingController();
  final _np2Controller = TextEditingController();
  String resultText = "";

  void _calculateResults() {
    int quantity = int.tryParse(_quantityController.text) ?? 0;
    double Phi = double.tryParse(_phiController.text) ?? 0.0;
    double nPhKv = double.tryParse(_nPhKvController.text) ?? 0.0;
    double nPnKvtg = double.tryParse(_nPnKvtgController.text) ?? 0.0;
    double np2 = double.tryParse(_np2Controller.text) ?? 0.0;

    var result = Calculations3.calculate(
      quantity: quantity,
      Phi: Phi,
      nPhKv: nPhKv,
      nPnKvtg: nPnKvtg,
      np2: np2,
    );

    setState(() {
      resultText = """
        Коефіцієнт використання цеху (Kv): ${result['Kv']!.toStringAsFixed(4)}
        Ефективна кількість ЕП (Ne): ${result['Ne']!.toStringAsFixed(2)}
        Розрахунковий коефіцієнт активної потужності (Kp): ${result['Kp']!.toStringAsFixed(2)}
        Активне навантаження (Pp): ${result['Pp']!.toStringAsFixed(2)} кВт
        Реактивне навантаження (Qp): ${result['Qp']!.toStringAsFixed(2)} кВАр
        Повна потужність (Sp): ${result['Sp']!.toStringAsFixed(2)} кВА
        Розрахунковий струм (Ip): ${result['Ip']!.toStringAsFixed(2)} А
      """;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Весь цех")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTextField(_quantityController, "Кількість ЕП"),
            _buildTextField(_phiController, "N * Pн"),
            _buildTextField(_nPhKvController, "nPhKv"),
            _buildTextField(_nPnKvtgController, "nPnKvtg"),
            _buildTextField(_np2Controller, "np2"),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _calculateResults, child: Text("Розрахувати")),
            SizedBox(height: 20),
            Text(resultText, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/calculations_task1.dart';
import '../widgets/input_field.dart';

class Task1Screen extends StatefulWidget {
  @override
  _Task1ScreenState createState() => _Task1ScreenState();
}

class _Task1ScreenState extends State<Task1Screen> {
  final TextEditingController smController = TextEditingController();
  final TextEditingController unomController = TextEditingController();
  final TextEditingController jekController = TextEditingController();
  final TextEditingController ikController = TextEditingController();
  final TextEditingController tfController = TextEditingController();
  final TextEditingController ctController = TextEditingController();

  String result = "Результат з'явиться тут";

  void calculate() {
    double Sm = double.tryParse(smController.text) ?? 0.0;
    double Unom = double.tryParse(unomController.text) ?? 0.0;
    double Jek = double.tryParse(jekController.text) ?? 0.0;
    double Ik = double.tryParse(ikController.text) ?? 0.0;
    double Tf = double.tryParse(tfController.text) ?? 0.0;
    double Ct = double.tryParse(ctController.text) ?? 0.0;

    final res = Task1Calculations.calculate(Sm, Unom, Jek, Ik, Tf, Ct);

    setState(() {
      result = """
Розрахунковий струм для нормального режиму Iм: ${res["Im"]!.toStringAsFixed(2)} А
Розрахунковий струм для післяаварійного режиму Iм.па: ${res["Ipa"]!.toStringAsFixed(2)} А
Економічний переріз: ${res["Sek"]!.toStringAsFixed(2)} мм²
Переріз для термостійкості: ${res["Smin"]!.toStringAsFixed(2)} мм²
""";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text("Розрахунок вибору кабелю", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          InputField(controller: smController, hint: "Розрахункове навантаження (кВА)"),
          InputField(controller: unomController, hint: "Номінальна напруга (кВ)"),
          InputField(controller: jekController, hint: "Економічна густина струму"),
          InputField(controller: ikController, hint: "Струм КЗ (А)"),
          InputField(controller: tfController, hint: "Час відключення (с)"),
          InputField(controller: ctController, hint: "Коеф. термостійкості"),
          SizedBox(height: 10),
          ElevatedButton(onPressed: calculate, child: Text("Розрахувати")),
          SizedBox(height: 10),
          Text(result, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

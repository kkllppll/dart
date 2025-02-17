import 'package:flutter/material.dart';
import '../models/element_model.dart';
import '../widgets/element_input_widget.dart';
import 'dart:math';

class Task1Screen extends StatefulWidget {
  @override
  _Task1ScreenState createState() => _Task1ScreenState();
}

class _Task1ScreenState extends State<Task1Screen> {
  final List<ElementModel> elements = [];
  final TextEditingController coefSimpleDowntimeController = TextEditingController();
  String resultText = "";

  void calculate() {
    double omegaSystem = elements.fold(0, (sum, el) => sum + el.omega);
    double avgRecoveryTime = omegaSystem > 0
        ? elements.fold(0.0, (sum, el) => sum + el.omega * el.recoveryTime) / omegaSystem
        : 0.0;

    avgRecoveryTime = (avgRecoveryTime * 10).roundToDouble() / 10.0;

    double kPlMax = double.tryParse(coefSimpleDowntimeController.text) ?? 0.0;
    double kAoc = (omegaSystem * avgRecoveryTime) / 8760;
    double kPlOc = (1.2 * kPlMax) / 8760;
    double omegaDk = 2 * omegaSystem * (kAoc + kPlOc);
    double omegaDs = omegaDk + 0.02;

    setState(() {
      resultText = """
Частота відмов одноколової системи: ${omegaSystem.toStringAsFixed(2)} рік^-1
Середній час відновлення: ${avgRecoveryTime.toStringAsFixed(2)} год.
Коефіцієнт аварійного простою: ${kAoc.toStringAsExponential(4)}
Коефіцієнт планового простою: ${kPlOc.toStringAsExponential(4)}
Частота відмов двоколової системи: ${omegaDk.toStringAsExponential(4)} рік^-1
Частота відмов двоколової системи з урахуванням секційного вимикача: ${omegaDs.toStringAsExponential(4)} рік^-1
""";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Порівняння надійності систем"), // Назва екрану
        ),
    body: Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() => elements.add(ElementModel(omega: 0, recoveryTime: 0)));
                },
                child: Text("Додати елемент"),
              ),
              ...elements.map((e) => ElementInputWidget(
                model: e,
                onRemove: () => setState(() => elements.remove(e)),
              )),
              TextField(
                controller: coefSimpleDowntimeController,
                decoration: InputDecoration(labelText: "Макс. коефіцієнт планового простою (год.)"),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: calculate, child: Text("Розрахувати")),
              SizedBox(height: 20),
              Text(resultText),
            ],
          ),
        ),
      ],
    )
    );
  }
}

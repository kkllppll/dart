import 'package:flutter/material.dart';

class Task2Screen extends StatefulWidget {
  @override
  _Task2ScreenState createState() => _Task2ScreenState();
}

class _Task2ScreenState extends State<Task2Screen> {
  final TextEditingController omegaController = TextEditingController();
  final TextEditingController tbController = TextEditingController();
  final TextEditingController pController = TextEditingController();
  final TextEditingController tController = TextEditingController();
  final TextEditingController kController = TextEditingController();
  final TextEditingController priceAController = TextEditingController();
  final TextEditingController pricePController = TextEditingController();
  String resultText = "";

  void calculate() {
    double omega = double.tryParse(omegaController.text) ?? 0.0;
    double tb = double.tryParse(tbController.text) ?? 0.0;
    double p = double.tryParse(pController.text) ?? 0.0;
    double T = double.tryParse(tController.text) ?? 0.0;
    double k = double.tryParse(kController.text) ?? 0.0;
    double priceA = double.tryParse(priceAController.text) ?? 0.0;
    double priceP = double.tryParse(pricePController.text) ?? 0.0;

    double mWnedA = omega * tb * p * T;
    double mWnedP = k * p * T;
    double Mzper = (priceA * mWnedA) + (priceP * mWnedP);

    setState(() {
      resultText = """
Математичне сподівання аварійного недовідпуску: ${mWnedA.toStringAsFixed(2)} кВт·год
Математичне сподівання планового недовідпуску: ${mWnedP.toStringAsFixed(2)} кВт·год
Загальні збитки: ${Mzper.toStringAsFixed(2)} грн
""";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Збитки від перерв електропостачання "), // Назва екрану
    ),
    body: Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              TextField(
                controller: omegaController,
                decoration: InputDecoration(labelText: "ω (рік^-1)"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: tbController,
                decoration: InputDecoration(labelText: "tB (год.)"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: pController,
                decoration: InputDecoration(labelText: "Pm (кВт)"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: tController,
                decoration: InputDecoration(labelText: "Tm"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: kController,
                decoration: InputDecoration(labelText: "kp"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: priceAController,
                decoration: InputDecoration(labelText: "Зпера (грн/кВт)"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: pricePController,
                decoration: InputDecoration(labelText: "Зперп (грн/кВт)"),
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

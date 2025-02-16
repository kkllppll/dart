import 'package:flutter/material.dart';
import '../models/calculations_task2.dart';
import '../widgets/input_field.dart';

class Task2Screen extends StatefulWidget {
  @override
  _Task2ScreenState createState() => _Task2ScreenState();
}

class _Task2ScreenState extends State<Task2Screen> {
  final TextEditingController usnController = TextEditingController();
  final TextEditingController skController = TextEditingController();
  final TextEditingController ukController = TextEditingController();
  final TextEditingController snomController = TextEditingController();

  String result = "Результат з'явиться тут";

  void calculate() {
    double Usn = double.tryParse(usnController.text) ?? 0.0;
    double Sk = double.tryParse(skController.text) ?? 0.0;
    double Uk = double.tryParse(ukController.text) ?? 0.0;
    double Snom = double.tryParse(snomController.text) ?? 0.0;

    final res = Task2Calculations.calculate(Usn, Sk, Uk, Snom);

    setState(() {
      result = """
Опір елементів заступної системи Xc: ${res["Xc"]!.toStringAsFixed(2)} Ом
Опір елементів заступної системи Xt: ${res["Xt"]!.toStringAsFixed(2)} Ом
Сумарний опір для точки К1 Xsum: ${res["Xsum"]!.toStringAsFixed(2)} Ом
Початкове діюче значення струму трифазного КЗ Ip0: ${res["Ip0"]!.toStringAsFixed(2)} кА
""";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text("Струми КЗ на шинах 10 кВ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          InputField(controller: usnController, hint: "Номінальна напруга"),
          InputField(controller: skController, hint: "Потужність короткого замикання"),
          InputField(controller: ukController, hint: "Короткозамкнена напруга (%)"),
          InputField(controller: snomController, hint: "Номінальна потужність трансформатора"),
          SizedBox(height: 10),
          ElevatedButton(onPressed: calculate, child: Text("Розрахувати")),
          SizedBox(height: 10),
          Text(result, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

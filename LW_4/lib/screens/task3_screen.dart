import 'package:flutter/material.dart';
import '../models/calculations_task3.dart';
import '../widgets/input_field.dart';

class Task3Screen extends StatefulWidget {
  @override
  _Task3ScreenState createState() => _Task3ScreenState();
}

class _Task3ScreenState extends State<Task3Screen> {
  final TextEditingController ukmaxController = TextEditingController();
  final TextEditingController uvnController = TextEditingController();
  final TextEditingController snomController = TextEditingController();
  final TextEditingController rcnController = TextEditingController();
  final TextEditingController xcnController = TextEditingController();
  final TextEditingController rcminController = TextEditingController();
  final TextEditingController xcminController = TextEditingController();
  final TextEditingController unnController = TextEditingController();

  final TextEditingController lengthsController = TextEditingController();
  final TextEditingController rLineController = TextEditingController();
  final TextEditingController xLineController = TextEditingController();

  String result = "Результат з'явиться тут";

  void calculate() {
    double Ukmax = double.tryParse(ukmaxController.text) ?? 0.0;
    double Uvn = double.tryParse(uvnController.text) ?? 0.0;
    double Snom = double.tryParse(snomController.text) ?? 0.0;
    double Rcn = double.tryParse(rcnController.text) ?? 0.0;
    double Xcn = double.tryParse(xcnController.text) ?? 0.0;
    double Rcmin = double.tryParse(rcminController.text) ?? 0.0;
    double Xcmin = double.tryParse(xcminController.text) ?? 0.0;
    double Unn = double.tryParse(unnController.text) ?? 0.0;

    List<double> lengths = lengthsController.text
        .split(',')
        .map((e) => double.tryParse(e.trim()) ?? 0.0)
        .toList();

    double rLine = double.tryParse(rLineController.text) ?? 0.0;
    double xLine = double.tryParse(xLineController.text) ?? 0.0;

    final res = Task3Calculations.calculate(
        Ukmax,
        Uvn,
        Snom,
        Rcn,
        Xcn,
        Rcmin,
        Xcmin,
        Unn,
        lengths,
        rLine,
        xLine);

    print(res);

    setState(() {
      result = """
    Реактивний опір трансформатора Xt: ${(res["Xt"] ?? 0.0).toStringAsFixed(2)} Ом
    Сумарний опір у нормальному режимі ZshNorm: ${res["ZshNorm"]!
          .toStringAsFixed(2)} Ом
    Сумарний опір у мінімальному режимі ZshMin: ${(res["ZshMin"] ?? 0.0)
          .toStringAsFixed(2)} Ом

    Струм трифазного КЗ у нормальному режимі Ish3Norm: ${res["Ish3Norm"]!
          .toStringAsFixed(2)} А
    Струм двофазного КЗ у нормальному режимі Ish2Norm: ${res["Ish2Norm"]!
          .toStringAsFixed(2)} А

    Струм трифазного КЗ у мінімальному режимі Ish3Min: ${res["Ish3Min"]!
          .toStringAsFixed(2)} А
    Струм двофазного КЗ у мінімальному режимі Ish2Min: ${res["Ish2Min"]!
          .toStringAsFixed(2)} А

    Коефіцієнт приведення kpr: ${res["kpr"]!.toStringAsFixed(5)}

    Опір на шинах у нормальному режимі RshNorm: ${res["RshNorm"]!
          .toStringAsFixed(2)} Ом
    Реактивний опір на шинах у нормальному режимі XshNorm: ${res["XshNorm"]!
          .toStringAsFixed(2)} Ом
    Сумарний опір на шинах у нормальному режимі ZshNormPr: ${res["ZshNormPr"]!
          .toStringAsFixed(2)} Ом

    Опір на шинах у мінімальному режимі RshMin: ${res["RshMin"]!
          .toStringAsFixed(2)} Ом
    Реактивний опір на шинах у мінімальному режимі XshMin: ${res["XshMin"]!
          .toStringAsFixed(2)} Ом
    Сумарний опір на шинах у мінімальному режимі ZshMinPr: ${res["ZshMinPr"]!
          .toStringAsFixed(2)} Ом

    Дійсний струм трифазного КЗ у нормальному режимі Ish3RealNorm: ${res["Ish3RealNorm"]!
          .toStringAsFixed(2)} А
    Дійсний струм двофазного КЗ у нормальному режимі Ish2RealNorm: ${res["Ish2RealNorm"]!
          .toStringAsFixed(2)} А

    Дійсний струм трифазного КЗ у мінімальному режимі Ish3RealMin: ${res["Ish3RealMin"]!
          .toStringAsFixed(2)} А
    Дійсний струм двофазного КЗ у мінімальному режимі Ish2RealMin: ${res["Ish2RealMin"]!
          .toStringAsFixed(2)} А
    
    Сумарний активний опір лінії: ${res["RlineSum"]!.toStringAsFixed(2)} Ом
    Сумарний реактивний опір лінії: ${res["XlineSum"]!.toStringAsFixed(2)} Ом
        
    Опір у нормальному режимі:
    RtotalNorm: ${res["RtotalNorm"]!.toStringAsFixed(2)} Ом
    XtotalNorm: ${res["XtotalNorm"]!.toStringAsFixed(2)} Ом
    ZtotalNorm: ${res["ZtotalNorm"]!.toStringAsFixed(2)} Ом
        
    Опір у мінімальному режимі:
    RtotalMin: ${res["RtotalMin"]!.toStringAsFixed(2)} Ом
    XtotalMin: ${res["XtotalMin"]!.toStringAsFixed(2)} Ом
    ZtotalMin: ${res["ZtotalMin"]!.toStringAsFixed(2)} Ом

    Струми КЗ у нормальному режимі:
    Iш3 (трифазний): ${res["I3phNorm"]!.toStringAsFixed(2)} А
    Iш2 (двофазний): ${res["I2phNorm"]!.toStringAsFixed(2)} А

    Струми КЗ у мінімальному режимі:
    Iш3 (трифазний): ${res["I3phMin"]!.toStringAsFixed(2)} А
    Iш2 (двофазний): ${res["I2phMin"]!.toStringAsFixed(2)} А
  """;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text("Розрахунок КЗ для підстанції ХПнЕМ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          InputField(controller: ukmaxController, hint: "Напруга трансформатора у відсотках (%)"),
          InputField(controller: uvnController, hint: "Номінальна напруга високовольтної частини (кВ)"),
          InputField(controller: snomController, hint: "Номінальна потужність трансформатора (МВА)"),
          InputField(controller: rcnController, hint: "Активний опір високовольтної частини (Ом)"),
          InputField(controller: xcnController, hint: "Реактивний опір на шинах у нормальному режимі (Ом)"),
          InputField(controller: rcminController, hint: "Активний опір у мінімальному режимі (Ом)"),
          InputField(controller: xcminController, hint: "Реактивний опір на шинах у мінімальному режимі (Ом)"),
          InputField(controller: unnController, hint: "Номінальна напруга (кВ)"),
          InputField(controller: lengthsController, hint: "Довжини ділянок через кому (км)"),
          InputField(controller: rLineController, hint: "Питомий активний опір (Ом/км)"),
          InputField(controller: xLineController, hint: "Питомий реактивний опір (Ом/км)"),
          SizedBox(height: 10),
          ElevatedButton(onPressed: calculate, child: Text("Розрахувати")),
          SizedBox(height: 10),
          Text(result, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

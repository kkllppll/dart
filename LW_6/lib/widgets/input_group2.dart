import 'package:flutter/material.dart';

class InputGroup2 extends StatelessWidget {
  final VoidCallback onRemove;
  final TextEditingController epNameController = TextEditingController();
  final TextEditingController etaController = TextEditingController();
  final TextEditingController cosPhiController = TextEditingController();
  final TextEditingController voltageController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController powerController = TextEditingController();
  final TextEditingController usageCoeffController = TextEditingController();
  final TextEditingController tgPhiController = TextEditingController();

  InputGroup2({required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: onRemove,
              ),
            ),
            TextField(controller: epNameController, decoration: InputDecoration(labelText: "Найменування ЕП")),
            TextField(controller: etaController, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: "Номінальний ККД (ηн)")),
            TextField(controller: cosPhiController, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: "Коефіцієнт потужності (cos φ)")),
            TextField(controller: voltageController, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: "Напруга (Uн)")),
            TextField(controller: quantityController, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: "Кількість ЕП")),
            TextField(controller: powerController, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: "Номінальна потужність (Pн)")),
            TextField(controller: usageCoeffController, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: "Коефіцієнт використання (Кв)")),
            TextField(controller: tgPhiController, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: "Коефіцієнт реактивної потужності (tg φ)")),
          ],
        ),
      ),
    );
  }
}

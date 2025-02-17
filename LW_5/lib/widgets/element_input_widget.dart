import 'package:flutter/material.dart';
import '../models/element_model.dart';

class ElementInputWidget extends StatefulWidget {
  final ElementModel model;
  final VoidCallback onRemove;

  ElementInputWidget({required this.model, required this.onRemove});

  @override
  _ElementInputWidgetState createState() => _ElementInputWidgetState();
}

class _ElementInputWidgetState extends State<ElementInputWidget> {
  late TextEditingController omegaController;
  late TextEditingController recoveryTimeController;

  @override
  void initState() {
    super.initState();
    omegaController = TextEditingController(text: widget.model.omega.toString());
    recoveryTimeController = TextEditingController(text: widget.model.recoveryTime.toString());
  }

  @override
  void dispose() {
    omegaController.dispose();
    recoveryTimeController.dispose();
    super.dispose();
  }

  void updateValues() {
    setState(() {
      widget.model.omega = double.tryParse(omegaController.text) ?? 0.0;
      widget.model.recoveryTime = double.tryParse(recoveryTimeController.text) ?? 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: omegaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Частота відмов (ω)"),
              onChanged: (value) => updateValues(),
            ),
            TextField(
              controller: recoveryTimeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Середній час відновлення"),
              onChanged: (value) => updateValues(),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: widget.onRemove,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text("Видалити", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

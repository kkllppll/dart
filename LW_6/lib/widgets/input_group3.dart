import 'package:flutter/material.dart';

class InputGroup3 extends StatelessWidget {
  final VoidCallback onRemove;
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController phiController = TextEditingController();
  final TextEditingController nPhKvController = TextEditingController();
  final TextEditingController nPnKvtgController = TextEditingController();
  final TextEditingController np2Controller = TextEditingController();

  InputGroup3({required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(controller: quantityController, decoration: InputDecoration(labelText: "Кількість ЕП")),
            TextField(controller: phiController, decoration: InputDecoration(labelText: "Phi")),
            TextField(controller: nPhKvController, decoration: InputDecoration(labelText: "nPhKv")),
            TextField(controller: nPnKvtgController, decoration: InputDecoration(labelText: "nPnKvtg")),
            TextField(controller: np2Controller, decoration: InputDecoration(labelText: "np2")),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: onRemove,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

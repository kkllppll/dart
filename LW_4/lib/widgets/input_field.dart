import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  InputField({required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: hint,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

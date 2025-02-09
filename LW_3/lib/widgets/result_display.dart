import 'package:flutter/material.dart';

class ResultDisplay extends StatelessWidget {
  final Map<String, double> results;

  ResultDisplay({required this.results});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Результати розрахунку:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        _buildResultSection("До вдосконалення", results, "delta_W1", "W1", "profit1", "W_penalty1", "penalty1", "netProfit1"),
        _buildResultSection("Після вдосконалення", results, "delta_W2", "W2", "profit2", "W_penalty2", "penalty2", "netProfit2"),
      ],
    );
  }

  Widget _buildResultSection(String title, Map<String, double> results, String delta, String w, String profit, String wPenalty, String penalty, String netProfit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text("Частка енергії без небалансів: ${results[delta]!.toStringAsFixed(2)}%"),
          Text("Згенерована енергія: ${results[w]!.toStringAsFixed(2)} МВт·год"),
          Text("Прибуток: ${results[profit]!.toStringAsFixed(2)} тис. грн"),
          Text("Залишок енергії: ${results[wPenalty]!.toStringAsFixed(2)} МВТ·год"),
          Text("Штраф: ${results[penalty]!.toStringAsFixed(2)} тис. грн"),
          Text("Чистий прибуток: ${results[netProfit]!.toStringAsFixed(2)} тис. грн"),
        ],
      ),
    );
  }
}

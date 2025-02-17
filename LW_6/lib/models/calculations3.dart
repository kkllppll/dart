import 'dart:math';

class Calculations3 {
  static double getSimultaneityCoefficient(double Kv, int connections) {
    final kvRanges = [0.3, 0.5, 0.8];
    final koTable = [
      [0.9, 0.8, 0.75, 0.7],  // Kv < 0.3
      [0.95, 0.9, 0.85, 0.8], // 0.3 ≤ Kv < 0.5
      [1.0, 0.95, 0.9, 0.85], // 0.5 ≤ Kv < 0.8
      [1.0, 1.0, 0.95, 0.9]   // Kv ≥ 0.8
    ];

    int kvIndex = Kv < kvRanges[0]
        ? 0
        : (Kv < kvRanges[1]
        ? 1
        : (Kv < kvRanges[2] ? 2 : 3));

    int connectionsIndex = connections <= 4
        ? 0
        : (connections <= 8
        ? 1
        : (connections <= 25 ? 2 : 3));

    return koTable[kvIndex][connectionsIndex];
  }

  static Map<String, double> calculate({
    required int quantity,
    required double Phi,
    required double nPhKv,
    required double nPnKvtg,
    required double np2,
  }) {
    double Kv = Phi > 0 ? nPhKv / Phi : 0.0;
    double Ne = np2 > 0 ? (Phi * Phi) / np2 : 0.0;
    double Kp = getSimultaneityCoefficient(Kv, quantity);
    double Pp = Kp * nPhKv;
    double Qp = Kp * nPnKvtg;
    double Sp = sqrt(Pp * Pp + Qp * Qp);
    double Uh = 0.38;
    double Ip = Pp / Uh;

    return {
      'Kv': Kv,
      'Ne': Ne,
      'Kp': Kp,
      'Pp': Pp,
      'Qp': Qp,
      'Sp': Sp,
      'Ip': Ip,
    };
  }
}

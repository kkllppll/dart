import 'dart:math';

import 'active_power_coefficient.dart';

class Calculations1 {
  static Map<String, double> calculate(List<Map<String, double>> groups) {
    double numerator = 0.0;
    double denominator = 0.0;
    double powerSum = 0.0;
    double powerSquaredSum = 0.0;
    double reactivePowerSum = 0.0;
    double totalVoltage = 0.0;
    int voltageCount = 0;
    int quantityNum = 0;

    for (var group in groups) {
      double quantity = group['quantity'] ?? 0.0;
      double power = group['power'] ?? 0.0;
      double usageCoeff = group['usageCoeff'] ?? 0.0;
      double tgPhi = group['tgPhi'] ?? 0.0;
      double voltage = group['voltage'] ?? 0.0;

      if (voltage > 0) {
        totalVoltage += voltage;
        voltageCount++;
      }

      numerator += quantity * power * usageCoeff;
      denominator += quantity * power;
      powerSum += quantity * power;
      powerSquaredSum += quantity * power * power;
      reactivePowerSum += quantity * power * usageCoeff * tgPhi;
      quantityNum += quantity.toInt();
    }

    double Uh = voltageCount > 0 ? totalVoltage / voltageCount : 0.0;
    if (Uh == 0.0) return {'error': -1}; // Код помилки, що напруга не задана

    double Kv = denominator > 0 ? numerator / denominator : 0.0;
    double Ne = powerSquaredSum > 0 ? (powerSum * powerSum) / powerSquaredSum : 0.0;
    double Kp = ActivePowerCoefficient.getActivePowerCoefficient(Kv, Ne);
    double Pp = Kp * numerator;
    double Qp = reactivePowerSum;
    double Sp = sqrt(Pp * Pp + Qp * Qp);
    double Ip = Pp / Uh;

    return {
      'Kv': Kv,
      'Ne': Ne,
      'Kp': Kp,
      'Pp': Pp,
      'Qp': Qp,
      'Sp': Sp,
      'Ip': Ip,
      'quantityNum': quantityNum.toDouble(),
      'nPh': denominator,
      'nPhKv': numerator,
      'nPh2': powerSquaredSum
    };
  }
}

import 'dart:math';

class Task1Calculations {
  static Map<String, double> calculate(double Sm, double Unom, double Jek, double Ik, double Tf, double Ct) {
    double Im = (Sm / 2) / (sqrt(3) * Unom);
    double Ipa = 2 * Im;
    double Sek = Im / Jek;
    double Smin = (Ik * sqrt(Tf)) / Ct;

    return {
      "Im": Im,
      "Ipa": Ipa,
      "Sek": Sek,
      "Smin": Smin,
    };
  }
}

import 'dart:math';

class Task2Calculations {
  static Map<String, double> calculate(double Usn, double Sk, double Uk, double Snom) {
    double Xc = pow(Usn, 2) / Sk;
    double Xt = Uk / 100 * pow(Usn, 2) / Snom;
    double Xsum = Xc + Xt;
    double Ip0 = Usn / (sqrt(3) * Xsum);

    return {
      "Xc": Xc,
      "Xt": Xt,
      "Xsum": Xsum,
      "Ip0": Ip0,
    };
  }
}

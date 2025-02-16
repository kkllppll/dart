import 'dart:math';

class Task3Calculations {
  static Map<String, double> calculate(
      double Ukmax,
      double Uvn,
      double Snom,
      double Rcn,
      double Xcn,
      double Rcmin,
      double Xcmin,
      double Unn,
      List<double> lengths,
      double rLine,
      double xLine,
      ) {

    // Реактивний опір трансформатора
    double Xt = (Ukmax * Uvn * Uvn) / (100 * Snom);

    // Сумарний опір у нормальному режимі
    double XsumNorm = Xcn + Xt;
    double ZshNorm = sqrt(Rcn * Rcn + XsumNorm * XsumNorm);

    // Сумарний опір у мінімальному режимі
    double XsumMin = Xcmin + Xt;
    double ZshMin = sqrt(Rcmin * Rcmin + XsumMin * XsumMin);

    // Струми трифазного КЗ у нормальному режимі
    double Ish3Norm = (Uvn * 1000) / (sqrt(3.0) * ZshNorm);

    // Струми двофазного КЗ у нормальному режимі
    double Ish2Norm = Ish3Norm * (sqrt(3.0) / 2);

    // Струми трифазного КЗ у мінімальному режимі
    double Ish3Min = (Uvn * 1000) / (sqrt(3.0) * ZshMin);

    // Струми двофазного КЗ у мінімальному режимі
    double Ish2Min = Ish3Min * (sqrt(3.0) / 2);

    // Коефіцієнт приведення
    double kpr = Unn * Unn / (Uvn * Uvn);

    // Опори на шинах у нормальному режимі з коефіцієнтом приведення
    double RshNorm = Rcn * kpr;
    double XshNorm = XsumNorm * kpr;
    double ZshNormPr = sqrt(RshNorm * RshNorm + XshNorm * XshNorm);

    // Опори на шинах у мінімальному режимі з коефіцієнтом приведення
    double RshMin = Rcmin * kpr;
    double XshMin = XsumMin * kpr;
    double ZshMinPr = sqrt(RshMin * RshMin + XshMin * XshMin);

    // Дійсні струми трифазного КЗ на шинах 10 кВ у нормальному режимі
    double Ish3RealNorm = (Uvn * 1000) / (sqrt(3.0) * ZshNormPr);

    // Дійсні струми двофазного КЗ на шинах 10 кВ у нормальному режимі
    double Ish2RealNorm = Ish3RealNorm * (sqrt(3.0) / 2);

    // Дійсні струми трифазного КЗ на шинах 10 кВ у мінімальному режимі
    double Ish3RealMin = (Uvn * 1000) / (sqrt(3.0) * ZshMinPr);

    // Дійсні струми двофазного КЗ на шинах 10 кВ у мінімальному режимі
    double Ish2RealMin = Ish3RealMin * (sqrt(3.0) / 2);

    // Розрахунок сумарних опорів ліній
    double RlineSum = 0.0;
    double XlineSum = 0.0;

    for (var length in lengths) {
      RlineSum += rLine * length;
      XlineSum += xLine * length;
    }

    // Сумарний опір у нормальному режимі
    double RtotalNorm = RshNorm + RlineSum;
    double XtotalNorm = XshNorm + XlineSum;
    double ZtotalNorm = sqrt(RtotalNorm * RtotalNorm + XtotalNorm * XtotalNorm);

    // Сумарний опір у мінімальному режимі
    double RtotalMin = RshMin + RlineSum;
    double XtotalMin = XshMin + XlineSum;
    double ZtotalMin = sqrt(RtotalMin * RtotalMin + XtotalMin * XtotalMin);

    // Струми трифазного КЗ
    double I3phNorm = (Unn * 1000) / (sqrt(3.0) * ZtotalNorm);
    double I3phMin = (Unn * 1000) / (sqrt(3.0) * ZtotalMin);

    // Струми двофазного КЗ
    double I2phNorm = I3phNorm * (sqrt(3.0) / 2);
    double I2phMin = I3phMin * (sqrt(3.0) / 2);

    // Підготовка результату
    return {
      "Xt": Xt,
      "ZshNorm": ZshNorm,
      "Ish3Norm": Ish3Norm,
      "Ish2Norm": Ish2Norm,
      "Ish3Min": Ish3Min,
      "Ish2Min": Ish2Min,
      "kpr": kpr,
      "RshNorm": RshNorm,
      "XshNorm": XshNorm,
      "ZshNormPr": ZshNormPr,
      "RshMin": RshMin,
      "XshMin": XshMin,
      "ZshMinPr": ZshMinPr,
      "Ish3RealNorm": Ish3RealNorm,
      "Ish2RealNorm": Ish2RealNorm,
      "Ish3RealMin": Ish3RealMin,
      "Ish2RealMin": Ish2RealMin,
      "RlineSum": RlineSum,
      "XlineSum": XlineSum,
      "RtotalNorm": RtotalNorm,
      "XtotalNorm": XtotalNorm,
      "ZtotalNorm": ZtotalNorm,
      "RtotalMin": RtotalMin,
      "XtotalMin": XtotalMin,
      "ZtotalMin": ZtotalMin,
      "I3phNorm": I3phNorm,
      "I3phMin": I3phMin,
      "I2phNorm": I2phNorm,
      "I2phMin": I2phMin,
      "ZshMin" : ZshMin,
    };
  }
}

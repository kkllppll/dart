class ActivePowerCoefficient {
  static double findClosestInTable(double value, List<double> values) {
    if (values.contains(value)) return values.indexOf(value).toDouble();

    if (value < values.first) return 0;
    if (value > values.last) return (values.length - 1).toDouble();

    for (int i = 0; i < values.length - 1; i++) {
      if (value > values[i] && value < values[i + 1]) {
        return (value - values[i] < values[i + 1] - value) ? i.toDouble() : (i + 1).toDouble();
      }
    }
    return 0;
  }

  static double getActivePowerCoefficient(double Kv, double ne) {
    List<double> kvValues = [0.1, 0.15, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8];
    List<double> neValues = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 25, 30, 35, 40, 50, 60, 80, 100];

    List<List<double>> kpTable = [
      [8.00, 5.33, 4.00, 2.67, 2.00, 1.60, 1.33, 1.14, 1.00],
      [6.22, 4.33, 3.39, 2.45, 1.98, 1.60, 1.33, 1.14, 1.00],
      [4.06, 2.89, 2.31, 1.74, 1.45, 1.34, 1.22, 1.14, 1.00],
      [3.24, 2.35, 1.91, 1.47, 1.25, 1.21, 1.12, 1.06, 1.00],
      [2.84, 2.09, 1.72, 1.35, 1.16, 1.16, 1.08, 1.03, 1.00],
      [2.64, 1.96, 1.62, 1.28, 1.14, 1.13, 1.06, 1.01, 1.00],
      [2.49, 1.86, 1.54, 1.23, 1.12, 1.10, 1.04, 1.01, 1.00],
      [2.37, 1.78, 1.48, 1.19, 1.10, 1.08, 1.02, 1.01, 1.00],
      [2.27, 1.71, 1.43, 1.16, 1.09, 1.07, 1.01, 1.01, 1.00],
      [2.18, 1.65, 1.39, 1.13, 1.07, 1.05, 1.01, 1.01, 1.00],
      [2.04, 1.56, 1.32, 1.08, 1.05, 1.03, 1.00, 1.00, 1.00],
      [1.94, 1.49, 1.27, 1.05, 1.02, 1.02, 1.00, 1.00, 1.00],
      [1.85, 1.43, 1.23, 1.02, 1.00, 1.00, 1.00, 1.00, 1.00],
      [1.78, 1.39, 1.19, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00],
      [1.72, 1.35, 1.16, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00],
      [1.60, 1.27, 1.10, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00],
      [1.51, 1.21, 1.05, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00],
      [1.44, 1.16, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00],
      [1.30, 1.07, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00],
      [1.25, 1.03, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00],
      [1.16, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00],
      [1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00],
    ];

    int closestKvIndex = findClosestInTable(Kv, kvValues).toInt();
    int closestNeIndex = findClosestInTable(ne, neValues).toInt();

    return kpTable[closestNeIndex][closestKvIndex];
  }
}

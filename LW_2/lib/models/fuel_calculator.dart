class FuelCalculator {
  double Q_iR = 0.0;
  double L = 0.0;
  double Ar = 0.0;
  double G = 0.0;
  double n = 0.0;
  double k = 0.0;
  double B = 0.0;

  void inputParameters(double Q_iR, double L, double Ar, double G, double n, double k, double B) {
    this.Q_iR = Q_iR;
    this.L = L;
    this.Ar = Ar;
    this.G = G;
    this.n = n;
    this.k = k;
    this.B = B;
  }

  double calculateEmissionFactor() {
    if (Q_iR == 0.0) throw Exception("Нижча теплота згоряння не може бути нульовою.");
    return (1_000_000 / Q_iR) * L * (Ar / (100 - G)) * (1 - n) + k;
  }

  double calculateTotalEmission() {
    double emissionFactor = calculateEmissionFactor();
    return 0.000001 * emissionFactor * Q_iR * B;
  }
}

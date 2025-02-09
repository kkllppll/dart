import 'dart:math';

class Calculator {
  double pc = 0.0;
  double sigmaP = 0.0;
  double sigmaLP = 0.0;
  double b = 0.0;

  void inputParameters(double pc, double sigmaP, double sigmaLP, double b) {
    this.pc = pc;
    this.sigmaP = sigmaP;
    this.sigmaLP = sigmaLP;
    this.b = b;
  }

  double _pD(double p, double sigma) {
    return (1 / (sigma * sqrt(2 * pi))) * exp(-pow(p - pc, 2) / (2 * pow(sigma, 2)));
  }

  double _calculateDeltaW(double pMin, double pMax, double deltaP, double sigma) {
    double sum = 0.0;
    double p = pMin;
    while (p <= pMax) {
      sum += _pD(p, sigma) * deltaP;
      p += deltaP;
    }
    return sum;
  }

  double _calculateEnergy(double deltaW) => deltaW * pc * 24;
  double _calculatePenaltyEnergy(double deltaW) => pc * 24 * (1 - deltaW);
  double _calculateProfit(double w) => w * b;
  double _calculatePenalty(double wTotal, double wSafe) => (wTotal - wSafe) * b;

  Map<String, double> calculate() {
    double deltaP = 0.001;
    double pMin = 4.75, pMax = 5.25;

    double deltaW1 = _calculateDeltaW(pMin, pMax, deltaP, sigmaP);
    double deltaW2 = _calculateDeltaW(pMin, pMax, deltaP, sigmaLP);

    double w1 = _calculateEnergy(deltaW1);
    double w2 = _calculateEnergy(deltaW2);

    double wPenalty1 = _calculatePenaltyEnergy(deltaW1);
    double wPenalty2 = _calculatePenaltyEnergy(deltaW2);

    double profit1 = _calculateProfit(w1);
    double profit2 = _calculateProfit(w2);

    double wTotal = _calculateEnergy(1.0);
    double penalty1 = _calculatePenalty(wTotal, w1);
    double penalty2 = _calculatePenalty(wTotal, w2);

    double netProfit1 = profit1 - penalty1;
    double netProfit2 = profit2 - penalty2;

    return {
      "delta_W1": deltaW1 * 100,
      "W1": w1,
      "profit1": profit1,
      "penalty1": penalty1,
      "netProfit1": netProfit1,
      "W_penalty1": wPenalty1,
      "delta_W2": deltaW2 * 100,
      "W2": w2,
      "profit2": profit2,
      "penalty2": penalty2,
      "netProfit2": netProfit2,
      "W_penalty2": wPenalty2,
    };
  }
}

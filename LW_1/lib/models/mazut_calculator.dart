class MazutCalculator {
  double carbonP = 0.0;
  double hydrogenP = 0.0;
  double oxygenP = 0.0;
  double sulfurP = 0.0;
  double lowerHeatingQ = 0.0;
  double waterP = 0.0;
  double ashP = 0.0;
  double vanadiumP = 0.0;

  // введення компонентів мазуту
  void inputFuelComponents(double carbon, double hydrogen, double oxygen,
      double sulfur, double lowerHeatingQ, double water, double ash, double vanadium) {
    carbonP = carbon;
    hydrogenP = hydrogen;
    oxygenP = oxygen;
    sulfurP = sulfur;
    this.lowerHeatingQ = lowerHeatingQ;
    waterP = water;
    ashP = ash;
    vanadiumP = vanadium;
  }

  // перерахунок складу від горючої маси до робочої
  Map<String, dynamic> combToWorking() {
    double coeffCombToWorking = (100 - waterP - ashP) / 100;
    double coeffCombToWorking2 = (100 - waterP) / 100;

    Map<String, double> composition = {
      "Carbon": carbonP * coeffCombToWorking,
      "Hydrogen": hydrogenP * coeffCombToWorking,
      "Oxygen": oxygenP * coeffCombToWorking,
      "Sulfur": sulfurP * coeffCombToWorking,
      "Ash": ashP * coeffCombToWorking2,
      "Vanadium": vanadiumP * coeffCombToWorking2,
    };

    return {"composition": composition, "coefficient": coeffCombToWorking};
  }

  // розрахунок теплоти згоряння робочої маси
  double calculateWorkingHeatingValue() {
    return lowerHeatingQ * (100 - waterP - ashP) / 100 - 0.025 * waterP;
  }
}

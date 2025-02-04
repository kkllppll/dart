class FuelCalculator {
  double hydrogenP = 0.0;
  double carbonP = 0.0;
  double sulfurP = 0.0;
  double nitrogenP = 0.0;
  double oxygenP = 0.0;
  double waterP = 0.0;
  double ashP = 0.0;

  // введення компонентів пального
  void inputFuelComponents(double hydrogen, double carbon, double sulfur,
      double nitrogen, double oxygen, double water, double ash) {
    hydrogenP = hydrogen;
    carbonP = carbon;
    sulfurP = sulfur;
    nitrogenP = nitrogen;
    oxygenP = oxygen;
    waterP = water;
    ashP = ash;
  }

  // розрахунок коефіцієнта робоча -> суха маса
  Map<String, dynamic> coeffWorkingToDry() {
    double coeff = 100 / (100 - waterP);
    Map<String, double> composition = {
      "Hydrogen": hydrogenP * coeff,
      "Carbon": carbonP * coeff,
      "Sulfur": sulfurP * coeff,
      "Nitrogen": nitrogenP * coeff,
      "Oxygen": oxygenP * coeff,
      "Ash": ashP * coeff,
    };

    double totalPercentage =
    composition.values.reduce((sum, value) => sum + value);

    if (totalPercentage < 99.0 || totalPercentage > 101.0) {
      throw Exception(
          "Сума компонентів сухої маси повинна бути близько 100%, отримано $totalPercentage%");
    }

    return {"composition": composition, "coefficient": coeff};
  }

  // розрахунок коефіцієнта робоча -> горюча маса
  Map<String, dynamic> coeffWorkingToComb() {
    double coeff = 100 / (100 - waterP - ashP);
    Map<String, double> composition = {
      "Hydrogen": hydrogenP * coeff,
      "Carbon": carbonP * coeff,
      "Sulfur": sulfurP * coeff,
      "Nitrogen": nitrogenP * coeff,
      "Oxygen": oxygenP * coeff,
    };

    double totalPercentage =
    composition.values.reduce((sum, value) => sum + value);

    if (totalPercentage < 99.0 || totalPercentage > 101.0) {
      throw Exception(
          "Сума компонентів горючої маси повинна бути близько 100%, отримано $totalPercentage%");
    }

    return {"composition": composition, "coefficient": coeff};
  }

  // розрахунок теплоти згоряння робочої маси
  double calculateLowerHeatingValueWorkingMass() {
    return 339 * carbonP +
        1030 * hydrogenP -
        108.8 * (oxygenP - sulfurP) -
        25 * waterP;
  }

  // розрахунок теплоти згоряння сухої маси
  double calculateLowerHeatingValueDryMass(double workingQ) {
    return (workingQ + 0.025 * waterP) * 100 / (100 - waterP);
  }

  // розрахунок теплоти згоряння горючої маси
  double calculateLowerHeatingValueCombustibleMass(double workingQ) {
    return (workingQ + 0.025 * waterP) * 100 / (100 - waterP - ashP);
  }
}

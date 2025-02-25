class BmiCalculation {
  /// Converts height from centimeters to meters.
  double _centimetersToMeters(double centimeters) {
    return centimeters / 100;
  }

  /// Converts height from feet to meters.
  double _feetToMeters(double feet) {
    return feet * 0.3048;
  }

  /// Converts weight from pounds to kilograms.
  double _poundsToKilograms(double pounds) {
    return pounds * 0.453592;
  }

  /// Calculates BMI using weight in kilograms and height in meters.
  double calculateBmi({
    required double weight,
    required double height,
    String weightUnit = 'kg', // 'kg' or 'pound'
    String heightUnit = 'm', // 'm', 'cm', or 'feet'
  }) {
    // Convert weight and height to metric units if necessary
    if (weightUnit == 'pound') {
      weight = _poundsToKilograms(weight);
    }
    if (heightUnit == 'cm') {
      height = _centimetersToMeters(height);
    } else if (heightUnit == 'feet') {
      height = _feetToMeters(height);
    }
    print("weight: $weight height:$height");

    if (height <= 0) {
      throw Exception('Height must be greater than zero.');
    }
    return weight / (height * height);
  }


}

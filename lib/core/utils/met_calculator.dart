/// Metabolic Equivalent of Task (MET) Calorie Burn Estimator
/// Provides scientific calorie expenditure calculations for various exercise modalities
/// using the standard physiological formula:
/// Calories = Duration (min) * (MET * 3.5 * weightKg / 200)
class MetCalculator {
  MetCalculator._();

  /// Standard MET values mapped by workout category and intensity
  static const Map<String, double> categoryMetValues = {
    'hiit': 8.5,
    'strength': 5.0,
    'yoga': 3.2,
    'cardio': 7.5,
    'stretching': 2.5,
    'running': 9.8,
    'walking': 3.5,
    'cycling': 7.0,
  };

  /// Calculates total active calories burned
  static int calculateCaloriesBurned({
    required String category,
    required int durationMinutes,
    double weightKg = 70.0,
  }) {
    if (durationMinutes <= 0 || weightKg <= 0) return 0;

    final normalizedCategory = category.toLowerCase().trim();
    final met = categoryMetValues[normalizedCategory] ?? 5.0;

    // Formula: (MET * 3.5 * weightKg / 200) * minutes
    final caloriesPerMinute = (met * 3.5 * weightKg) / 200.0;
    final totalCalories = caloriesPerMinute * durationMinutes;

    return totalCalories.round();
  }

  /// Calculates the recommended active minutes required to reach a target calorie burn
  static int estimateDurationForCalorieTarget({
    required String category,
    required int targetCalories,
    double weightKg = 70.0,
  }) {
    if (targetCalories <= 0 || weightKg <= 0) return 0;

    final normalizedCategory = category.toLowerCase().trim();
    final met = categoryMetValues[normalizedCategory] ?? 5.0;
    final caloriesPerMinute = (met * 3.5 * weightKg) / 200.0;

    if (caloriesPerMinute <= 0) return 0;
    return (targetCalories / caloriesPerMinute).ceil();
  }
}

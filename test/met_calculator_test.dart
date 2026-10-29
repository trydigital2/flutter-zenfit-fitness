import 'package:flutter_test/flutter_test.dart';
import 'package:zenfit/core/utils/met_calculator.dart';

void main() {
  group('MetCalculator', () {
    test('calculates accurate calorie expenditure for 30 min HIIT session', () {
      final calories = MetCalculator.calculateCaloriesBurned(
        category: 'hiit',
        durationMinutes: 30,
        weightKg: 70.0,
      );
      expect(calories, equals(312));
    });

    test('calculates accurate calorie expenditure for 45 min Yoga session', () {
      final calories = MetCalculator.calculateCaloriesBurned(
        category: 'yoga',
        durationMinutes: 45,
        weightKg: 60.0,
      );
      expect(calories, equals(151));
    });

    test('returns 0 for zero or negative duration or weight', () {
      expect(
        MetCalculator.calculateCaloriesBurned(
          category: 'cardio',
          durationMinutes: 0,
          weightKg: 70.0,
        ),
        equals(0),
      );
      expect(
        MetCalculator.calculateCaloriesBurned(
          category: 'cardio',
          durationMinutes: 30,
          weightKg: -5.0,
        ),
        equals(0),
      );
    });

    test('estimates required duration to burn 300 kcal with running', () {
      final duration = MetCalculator.estimateDurationForCalorieTarget(
        category: 'running',
        targetCalories: 300,
        weightKg: 70.0,
      );
      expect(duration, equals(25));
    });
  });
}

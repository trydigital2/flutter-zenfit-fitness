import 'package:flutter_test/flutter_test.dart';
import 'package:zenfit/data/models/goal_model.dart';
import 'package:zenfit/data/models/activity_summary_model.dart';
import 'package:zenfit/data/models/habit_model.dart';

void main() {
  group('Goal Progress & Habit Streak Calculations Tests', () {
    test('GoalModel calculates progressPercentage clamped between 0 and 1', () {
      const stepGoal = GoalModel(
        id: 'steps',
        type: GoalType.steps,
        title: 'Steps',
        targetValue: 10000,
        currentValue: 6450,
        unit: 'steps',
      );

      expect(stepGoal.progressPercentage, closeTo(0.645, 0.001));
      expect(stepGoal.isCompleted, false);

      final completedGoal = stepGoal.copyWith(currentValue: 12000);
      expect(completedGoal.progressPercentage, 1.0);
      expect(completedGoal.isCompleted, true);
    });

    test(
      'ActivitySummaryModel overallDailyScore calculates average progress',
      () {
        final activity = ActivitySummaryModel(
          date: DateTime.now(),
          steps: 5000,
          calories: 250,
          activeMinutes: 30,
          waterLiters: 1.25,
          targetSteps: 10000, // 50%
          targetCalories: 500, // 50%
          targetActiveMinutes: 60, // 50%
          targetWaterLiters: 2.5, // 50%
        );

        expect(activity.overallDailyScore, closeTo(50.0, 0.1));
      },
    );

    test('HabitModel streak computation and date toggling', () {
      final now = DateTime.now();
      String dayKey(int daysAgo) {
        final d = now.subtract(Duration(days: daysAgo));
        return '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
      }

      final habit = HabitModel(
        id: 'h_test',
        title: 'Morning Yoga',
        category: 'Fitness',
        iconCodePoint: 0,
        colorHex: 0xFF10B981,
        completedDates: [
          dayKey(0), // Today
          dayKey(1), // Yesterday
          dayKey(2), // 2 days ago
        ],
      );

      expect(habit.isCompletedToday, true);
      expect(habit.currentStreak, 3);

      final toggled = habit.toggleToday();
      expect(toggled.isCompletedToday, false);
    });
  });
}

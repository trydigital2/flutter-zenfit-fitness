import '../models/activity_summary_model.dart';
import '../models/workout_history_model.dart';
import '../models/goal_model.dart';

class MockActivity {
  MockActivity._();

  static ActivitySummaryModel getTodayDefault() {
    return ActivitySummaryModel(
      date: DateTime.now(),
      steps: 6450,
      calories: 320,
      activeMinutes: 35,
      waterLiters: 1.5,
      targetSteps: 10000,
      targetCalories: 500,
      targetActiveMinutes: 60,
      targetWaterLiters: 2.5,
    );
  }

  static List<ActivitySummaryModel> getPastWeekActivity() {
    final now = DateTime.now();
    return [
      ActivitySummaryModel(
        date: now.subtract(const Duration(days: 6)),
        steps: 8200,
        calories: 410,
        activeMinutes: 45,
        waterLiters: 2.2,
      ),
      ActivitySummaryModel(
        date: now.subtract(const Duration(days: 5)),
        steps: 10450,
        calories: 540,
        activeMinutes: 65,
        waterLiters: 2.6,
      ),
      ActivitySummaryModel(
        date: now.subtract(const Duration(days: 4)),
        steps: 7300,
        calories: 380,
        activeMinutes: 38,
        waterLiters: 2.0,
      ),
      ActivitySummaryModel(
        date: now.subtract(const Duration(days: 3)),
        steps: 11200,
        calories: 590,
        activeMinutes: 70,
        waterLiters: 2.8,
      ),
      ActivitySummaryModel(
        date: now.subtract(const Duration(days: 2)),
        steps: 9150,
        calories: 460,
        activeMinutes: 50,
        waterLiters: 2.4,
      ),
      ActivitySummaryModel(
        date: now.subtract(const Duration(days: 1)),
        steps: 10100,
        calories: 520,
        activeMinutes: 58,
        waterLiters: 2.5,
      ),
      getTodayDefault(),
    ];
  }

  static List<WorkoutHistoryModel> getInitialWorkoutHistory() {
    final now = DateTime.now();
    return [
      WorkoutHistoryModel(
        id: 'hist_01',
        workoutId: 'w_01',
        workoutTitle: 'Full Body HIIT Blast',
        category: 'HIIT',
        completedAt: now.subtract(const Duration(hours: 3)),
        durationMinutes: 28,
        caloriesBurned: 320,
        exercisesCompleted: 5,
      ),
      WorkoutHistoryModel(
        id: 'hist_02',
        workoutId: 'w_02',
        workoutTitle: 'Dumbbell Upper Body Power',
        category: 'Strength',
        completedAt: now.subtract(const Duration(days: 1, hours: 2)),
        durationMinutes: 45,
        caloriesBurned: 390,
        exercisesCompleted: 5,
      ),
      WorkoutHistoryModel(
        id: 'hist_03',
        workoutId: 'w_03',
        workoutTitle: 'Morning Vinyasa Flow',
        category: 'Yoga',
        completedAt: now.subtract(const Duration(days: 2, hours: 4)),
        durationMinutes: 20,
        caloriesBurned: 130,
        exercisesCompleted: 5,
      ),
      WorkoutHistoryModel(
        id: 'hist_04',
        workoutId: 'w_06',
        workoutTitle: 'Lower Body Glute & Quad Builder',
        category: 'Strength',
        completedAt: now.subtract(const Duration(days: 3, hours: 5)),
        durationMinutes: 40,
        caloriesBurned: 360,
        exercisesCompleted: 3,
      ),
      WorkoutHistoryModel(
        id: 'hist_05',
        workoutId: 'w_05',
        workoutTitle: 'Cardio Kickboxing Sprint',
        category: 'Cardio',
        completedAt: now.subtract(const Duration(days: 4, hours: 1)),
        durationMinutes: 30,
        caloriesBurned: 350,
        exercisesCompleted: 3,
      ),
      WorkoutHistoryModel(
        id: 'hist_06',
        workoutId: 'w_04',
        workoutTitle: 'Core & Six-Pack Shred',
        category: 'Core',
        completedAt: now.subtract(const Duration(days: 6, hours: 3)),
        durationMinutes: 18,
        caloriesBurned: 160,
        exercisesCompleted: 4,
      ),
      WorkoutHistoryModel(
        id: 'hist_07',
        workoutId: 'w_10',
        workoutTitle: 'Kettlebell Complex Conditioning',
        category: 'Strength',
        completedAt: now.subtract(const Duration(days: 7, hours: 2)),
        durationMinutes: 32,
        caloriesBurned: 380,
        exercisesCompleted: 2,
      ),
      WorkoutHistoryModel(
        id: 'hist_08',
        workoutId: 'w_01',
        workoutTitle: 'Full Body HIIT Blast',
        category: 'HIIT',
        completedAt: now.subtract(const Duration(days: 9)),
        durationMinutes: 28,
        caloriesBurned: 320,
        exercisesCompleted: 5,
      ),
      WorkoutHistoryModel(
        id: 'hist_09',
        workoutId: 'w_07',
        workoutTitle: 'Full Body Mobility & Stretch',
        category: 'Stretching',
        completedAt: now.subtract(const Duration(days: 10)),
        durationMinutes: 15,
        caloriesBurned: 80,
        exercisesCompleted: 3,
      ),
      WorkoutHistoryModel(
        id: 'hist_10',
        workoutId: 'w_02',
        workoutTitle: 'Dumbbell Upper Body Power',
        category: 'Strength',
        completedAt: now.subtract(const Duration(days: 11)),
        durationMinutes: 45,
        caloriesBurned: 390,
        exercisesCompleted: 5,
      ),
      WorkoutHistoryModel(
        id: 'hist_11',
        workoutId: 'w_12',
        workoutTitle: '5K Runner Preparation Drills',
        category: 'Cardio',
        completedAt: now.subtract(const Duration(days: 12)),
        durationMinutes: 25,
        caloriesBurned: 240,
        exercisesCompleted: 2,
      ),
      WorkoutHistoryModel(
        id: 'hist_12',
        workoutId: 'w_06',
        workoutTitle: 'Lower Body Glute & Quad Builder',
        category: 'Strength',
        completedAt: now.subtract(const Duration(days: 13)),
        durationMinutes: 40,
        caloriesBurned: 360,
        exercisesCompleted: 3,
      ),
      WorkoutHistoryModel(
        id: 'hist_13',
        workoutId: 'w_03',
        workoutTitle: 'Morning Vinyasa Flow',
        category: 'Yoga',
        completedAt: now.subtract(const Duration(days: 14)),
        durationMinutes: 20,
        caloriesBurned: 130,
        exercisesCompleted: 5,
      ),
    ];
  }

  static List<GoalModel> getDefaultGoals() {
    return const [
      GoalModel(
        id: 'goal_steps',
        type: GoalType.steps,
        title: 'Daily Steps',
        targetValue: 10000,
        currentValue: 6450,
        unit: 'steps',
      ),
      GoalModel(
        id: 'goal_calories',
        type: GoalType.calories,
        title: 'Calorie Burn',
        targetValue: 500,
        currentValue: 320,
        unit: 'kcal',
      ),
      GoalModel(
        id: 'goal_water',
        type: GoalType.water,
        title: 'Water Intake',
        targetValue: 2.5,
        currentValue: 1.5,
        unit: 'L',
      ),
      GoalModel(
        id: 'goal_active',
        type: GoalType.activeMinutes,
        title: 'Active Minutes',
        targetValue: 60,
        currentValue: 35,
        unit: 'min',
      ),
    ];
  }
}

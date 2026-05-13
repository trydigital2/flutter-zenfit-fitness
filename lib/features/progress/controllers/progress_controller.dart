import 'package:get/get.dart';
import '../../../data/models/workout_history_model.dart';
import '../../../data/models/activity_summary_model.dart';
import '../../../data/repositories/workout_repository.dart';
import '../../../data/repositories/activity_repository.dart';

class ProgressController extends GetxController {
  final WorkoutRepository _workoutRepo = Get.find<WorkoutRepository>();
  final ActivityRepository _activityRepo = Get.find<ActivityRepository>();

  final historyList = <WorkoutHistoryModel>[].obs;
  final weeklyActivity = <ActivitySummaryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadProgress();
  }

  void loadProgress() {
    historyList.value = _workoutRepo.getWorkoutHistory();
    weeklyActivity.value = _activityRepo.getPastWeekActivity();
  }

  int get totalWorkouts => historyList.length;

  int get totalMinutes => historyList.isEmpty
      ? 0
      : historyList.map((e) => e.durationMinutes).reduce((a, b) => a + b);

  int get totalCalories => historyList.isEmpty
      ? 0
      : historyList.map((e) => e.caloriesBurned).reduce((a, b) => a + b);

  final streak = 7.obs;

  int get currentStreak => streak.value;

  int get longestWorkoutMinutes => historyList.isEmpty
      ? 0
      : historyList
            .map((e) => e.durationMinutes)
            .reduce((a, b) => a > b ? a : b);

  int get mostCaloriesBurned => historyList.isEmpty
      ? 0
      : historyList
            .map((e) => e.caloriesBurned)
            .reduce((a, b) => a > b ? a : b);
}

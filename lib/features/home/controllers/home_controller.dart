import 'package:get/get.dart';
import '../../../data/models/activity_summary_model.dart';
import '../../../data/models/user_profile_model.dart';
import '../../../data/models/workout_model.dart';
import '../../../data/models/goal_model.dart';
import '../../../data/models/habit_model.dart';
import '../../../data/repositories/activity_repository.dart';
import '../../../data/repositories/workout_repository.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../core/utils/date_formatter.dart';

class HomeController extends GetxController {
  final ActivityRepository _activityRepo = Get.find<ActivityRepository>();
  final WorkoutRepository _workoutRepo = Get.find<WorkoutRepository>();
  final UserRepository _userRepo = Get.find<UserRepository>();

  final todayActivity = Rxn<ActivitySummaryModel>();
  final userProfile = Rxn<UserProfileModel>();
  final todayWorkout = Rxn<WorkoutModel>();
  final recommendedWorkouts = <WorkoutModel>[].obs;
  final weeklyActivity = <ActivitySummaryModel>[].obs;
  final goals = <GoalModel>[].obs;
  final habits = <HabitModel>[].obs;
  final unreadNotificationsCount = 0.obs;

  final motivationalQuotes = [
    {
      'quote': 'The body achieves what the mind believes.',
      'author': 'Napoleon Hill',
    },
    {
      'quote': 'Action is the foundational key to all success.',
      'author': 'Pablo Picasso',
    },
    {
      'quote': 'Small daily improvements over time lead to stunning results.',
      'author': 'Robin Sharma',
    },
    {
      'quote':
          'Consistency isn’t about being perfect. It’s about not giving up.',
      'author': 'ZenFit Wisdom',
    },
  ];

  final currentQuoteIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadDashboardData();
  }

  void loadDashboardData() {
    userProfile.value = _userRepo.getUserProfile();
    todayActivity.value = _activityRepo.getTodayActivity();
    weeklyActivity.value = _activityRepo.getPastWeekActivity();
    goals.value = _activityRepo.getGoals();
    habits.value = _activityRepo.getHabits();

    final allWorkouts = _workoutRepo.getAllWorkouts();
    if (allWorkouts.isNotEmpty) {
      todayWorkout.value = allWorkouts[0]; // Full Body HIIT Blast
      recommendedWorkouts.value = allWorkouts.skip(1).take(5).toList();
    }

    final notifs = _activityRepo.getNotifications();
    unreadNotificationsCount.value = notifs.where((n) => !n.isRead).length;
  }

  String get greeting =>
      '${DateFormatter.getGreeting()}, ${userProfile.value?.name.split(' ').first ?? 'Friend'}';

  Future<void> addWaterQuick() async {
    final updated = await _activityRepo.addWater(0.25);
    todayActivity.value = updated;

    // update goal for water
    final currentGoals = List<GoalModel>.from(goals);
    final waterGoalIndex = currentGoals.indexWhere(
      (g) => g.type == GoalType.water,
    );
    if (waterGoalIndex != -1) {
      final updatedGoal = currentGoals[waterGoalIndex].copyWith(
        currentValue: updated.waterLiters,
      );
      currentGoals[waterGoalIndex] = updatedGoal;
      goals.value = currentGoals;
      await _activityRepo.updateGoal(updatedGoal);
    }
  }

  void refreshMetrics() {
    todayActivity.value = _activityRepo.getTodayActivity();
    weeklyActivity.value = _activityRepo.getPastWeekActivity();
    final notifs = _activityRepo.getNotifications();
    unreadNotificationsCount.value = notifs.where((n) => !n.isRead).length;
  }
}

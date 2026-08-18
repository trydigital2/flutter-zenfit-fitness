import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/goal_model.dart';
import '../../../data/models/habit_model.dart';
import '../../../data/repositories/activity_repository.dart';
import '../../home/controllers/home_controller.dart';

class GoalsController extends GetxController {
  final ActivityRepository _activityRepo = Get.find<ActivityRepository>();

  final goals = <GoalModel>[].obs;
  final habits = <HabitModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadGoalsAndHabits();
  }

  void loadGoalsAndHabits() {
    goals.value = _activityRepo.getGoals();
    habits.value = _activityRepo.getHabits();
  }

  Future<void> updateGoalTarget(String goalId, double newTarget) async {
    final index = goals.indexWhere((g) => g.id == goalId);
    if (index != -1) {
      final updated = goals[index].copyWith(targetValue: newTarget);
      goals[index] = updated;
      await _activityRepo.updateGoal(updated);
      if (Get.isRegistered<HomeController>()) {
        Get.find<HomeController>().loadDashboardData();
      }
    }
  }

  Future<void> toggleHabitDay(String habitId, DateTime date) async {
    final updatedList = await _activityRepo.toggleHabit(habitId, date);
    habits.value = updatedList;
    if (Get.isRegistered<HomeController>()) {
      Get.find<HomeController>().loadDashboardData();
    }
  }

  Future<void> addCustomHabit({
    required String title,
    required String category,
    required IconData icon,
    required Color color,
    int targetDays = 7,
  }) async {
    final newHabit = HabitModel(
      id: 'habit_${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      category: category,
      iconCodePoint: icon.codePoint,
      colorHex: color.toARGB32(),
      completedDates: [],
      targetDaysPerWeek: targetDays,
    );

    await _activityRepo.addCustomHabit(newHabit);
    habits.value = _activityRepo.getHabits();
  }
}

import '../models/activity_summary_model.dart';
import '../models/goal_model.dart';
import '../models/habit_model.dart';
import '../models/notification_model.dart';
import '../mock/mock_activity.dart';
import '../mock/mock_habits.dart';
import '../mock/mock_notifications.dart';
import '../../core/services/storage_service.dart';

class ActivityRepository {
  final StorageService _storage;

  ActivityRepository(this._storage);

  ActivitySummaryModel getTodayActivity() {
    final saved = _storage.getTodayActivity();
    if (saved != null) return saved;
    final initial = MockActivity.getTodayDefault();
    _storage.saveTodayActivity(initial);
    return initial;
  }

  Future<void> updateTodayActivity(ActivitySummaryModel activity) async {
    await _storage.saveTodayActivity(activity);
  }

  Future<ActivitySummaryModel> addWater(double litersToAdd) async {
    final current = getTodayActivity();
    final updated = current.copyWith(
      waterLiters: (current.waterLiters + litersToAdd).clamp(0.0, 10.0),
    );
    await updateTodayActivity(updated);
    return updated;
  }

  Future<ActivitySummaryModel> recordWorkoutCompletion({
    required int caloriesBurned,
    required int durationMinutes,
  }) async {
    final current = getTodayActivity();
    final updated = current.copyWith(
      calories: current.calories + caloriesBurned,
      activeMinutes: current.activeMinutes + durationMinutes,
    );
    await updateTodayActivity(updated);
    return updated;
  }

  List<ActivitySummaryModel> getPastWeekActivity() {
    return MockActivity.getPastWeekActivity();
  }

  // Goals
  List<GoalModel> getGoals() {
    final saved = _storage.getDailyGoals();
    if (saved != null) return saved;
    final initial = MockActivity.getDefaultGoals();
    _storage.saveDailyGoals(initial);
    return initial;
  }

  Future<void> updateGoal(GoalModel goal) async {
    final goals = getGoals();
    final index = goals.indexWhere((g) => g.id == goal.id);
    if (index != -1) {
      goals[index] = goal;
    } else {
      goals.add(goal);
    }
    await _storage.saveDailyGoals(goals);
  }

  // Habits
  List<HabitModel> getHabits() {
    final saved = _storage.getHabits();
    if (saved != null) return saved;
    final initial = MockHabits.getDefaultHabits();
    _storage.saveHabits(initial);
    return initial;
  }

  Future<void> saveHabits(List<HabitModel> habits) async {
    await _storage.saveHabits(habits);
  }

  Future<List<HabitModel>> toggleHabit(String habitId, DateTime date) async {
    final habits = getHabits();
    final index = habits.indexWhere((h) => h.id == habitId);
    if (index != -1) {
      habits[index] = habits[index].toggleDate(date);
      await saveHabits(habits);
    }
    return habits;
  }

  Future<void> addCustomHabit(HabitModel habit) async {
    final habits = getHabits();
    habits.add(habit);
    await saveHabits(habits);
  }

  // Notifications
  List<NotificationModel> getNotifications() {
    final saved = _storage.getNotifications();
    if (saved != null) return saved;
    final initial = MockNotifications.getDefaultNotifications();
    _storage.saveNotifications(initial);
    return initial;
  }

  Future<void> markNotificationAsRead(String notifId) async {
    final notifs = getNotifications();
    final index = notifs.indexWhere((n) => n.id == notifId);
    if (index != -1) {
      notifs[index] = notifs[index].copyWith(isRead: true);
      await _storage.saveNotifications(notifs);
    }
  }

  Future<void> markAllNotificationsAsRead() async {
    final notifs = getNotifications();
    final updated = notifs.map((n) => n.copyWith(isRead: true)).toList();
    await _storage.saveNotifications(updated);
  }

  Future<void> clearAllNotifications() async {
    await _storage.saveNotifications([]);
  }
}

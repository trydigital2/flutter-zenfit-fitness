import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';
import '../../data/models/user_profile_model.dart';
import '../../data/models/workout_history_model.dart';
import '../../data/models/meal_model.dart';
import '../../data/models/goal_model.dart';
import '../../data/models/habit_model.dart';
import '../../data/models/activity_summary_model.dart';
import '../../data/models/notification_model.dart';

class StorageService extends GetxService {
  late SharedPreferences _prefs;

  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  // Onboarding
  bool get hasSeenOnboarding =>
      _prefs.getBool(AppConstants.keyHasSeenOnboarding) ?? false;

  Future<void> setHasSeenOnboarding(bool value) async {
    await _prefs.setBool(AppConstants.keyHasSeenOnboarding, value);
  }

  // Theme mode
  bool get isDarkMode => _prefs.getBool(AppConstants.keyThemeMode) ?? false;

  Future<void> setDarkMode(bool value) async {
    await _prefs.setBool(AppConstants.keyThemeMode, value);
  }

  // Favorites - Workouts
  List<String> getFavoriteWorkoutIds() {
    return _prefs.getStringList(AppConstants.keyFavoriteWorkouts) ?? [];
  }

  Future<void> saveFavoriteWorkoutIds(List<String> ids) async {
    await _prefs.setStringList(AppConstants.keyFavoriteWorkouts, ids);
  }

  // Favorites - Meditations
  List<String> getFavoriteMeditationIds() {
    return _prefs.getStringList(AppConstants.keyFavoriteMeditations) ?? [];
  }

  Future<void> saveFavoriteMeditationIds(List<String> ids) async {
    await _prefs.setStringList(AppConstants.keyFavoriteMeditations, ids);
  }

  // User Profile
  UserProfileModel? getUserProfile() {
    final raw = _prefs.getString(AppConstants.keyUserProfile);
    if (raw == null) return null;
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return UserProfileModel.fromJson(map);
    } catch (_) {
      return null;
    }
  }

  Future<void> saveUserProfile(UserProfileModel profile) async {
    await _prefs.setString(
      AppConstants.keyUserProfile,
      jsonEncode(profile.toJson()),
    );
  }

  // Workout History
  List<WorkoutHistoryModel>? getWorkoutHistory() {
    final raw = _prefs.getString(AppConstants.keyWorkoutHistory);
    if (raw == null) return null;
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list
          .map((e) => WorkoutHistoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return null;
    }
  }

  Future<void> saveWorkoutHistory(List<WorkoutHistoryModel> history) async {
    final list = history.map((e) => e.toJson()).toList();
    await _prefs.setString(AppConstants.keyWorkoutHistory, jsonEncode(list));
  }

  // Logged Meals
  List<MealModel>? getLoggedMeals() {
    final raw = _prefs.getString(AppConstants.keyLoggedMeals);
    if (raw == null) return null;
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list
          .map((e) => MealModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return null;
    }
  }

  Future<void> saveLoggedMeals(List<MealModel> meals) async {
    final list = meals.map((e) => e.toJson()).toList();
    await _prefs.setString(AppConstants.keyLoggedMeals, jsonEncode(list));
  }

  // Daily Goals
  List<GoalModel>? getDailyGoals() {
    final raw = _prefs.getString(AppConstants.keyDailyGoals);
    if (raw == null) return null;
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list
          .map((e) => GoalModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return null;
    }
  }

  Future<void> saveDailyGoals(List<GoalModel> goals) async {
    final list = goals.map((e) => e.toJson()).toList();
    await _prefs.setString(AppConstants.keyDailyGoals, jsonEncode(list));
  }

  // Habits
  List<HabitModel>? getHabits() {
    final raw = _prefs.getString(AppConstants.keyHabits);
    if (raw == null) return null;
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list
          .map((e) => HabitModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return null;
    }
  }

  Future<void> saveHabits(List<HabitModel> habits) async {
    final list = habits.map((e) => e.toJson()).toList();
    await _prefs.setString(AppConstants.keyHabits, jsonEncode(list));
  }

  // Today Activity
  ActivitySummaryModel? getTodayActivity() {
    final raw = _prefs.getString(AppConstants.keyTodayActivity);
    if (raw == null) return null;
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return ActivitySummaryModel.fromJson(map);
    } catch (_) {
      return null;
    }
  }

  Future<void> saveTodayActivity(ActivitySummaryModel activity) async {
    await _prefs.setString(
      AppConstants.keyTodayActivity,
      jsonEncode(activity.toJson()),
    );
  }

  // Notifications
  List<NotificationModel>? getNotifications() {
    final raw = _prefs.getString(AppConstants.keyNotifications);
    if (raw == null) return null;
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list
          .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return null;
    }
  }

  Future<void> saveNotifications(List<NotificationModel> notifications) async {
    final list = notifications.map((e) => e.toJson()).toList();
    await _prefs.setString(AppConstants.keyNotifications, jsonEncode(list));
  }

  // Reset Demo Data
  Future<void> resetAllData() async {
    await _prefs.clear();
  }
}

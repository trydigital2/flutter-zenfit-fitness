class AppConstants {
  AppConstants._();

  static const String appName = 'ZenFit';
  static const String appTagline = 'Move Better. Feel Better. Live Better.';
  static const String appVersion = '1.0.0';
  static const String buildNumber = '1';

  // Storage Keys
  static const String keyHasSeenOnboarding = 'zenfit_has_seen_onboarding';
  static const String keyThemeMode = 'zenfit_theme_mode';
  static const String keyUserProfile = 'zenfit_user_profile';
  static const String keyFavoriteWorkouts = 'zenfit_fav_workouts';
  static const String keyFavoriteMeditations = 'zenfit_fav_meditations';
  static const String keyWorkoutHistory = 'zenfit_workout_history';
  static const String keyLoggedMeals = 'zenfit_logged_meals';
  static const String keyTodayActivity = 'zenfit_today_activity';
  static const String keyDailyGoals = 'zenfit_daily_goals';
  static const String keyHabits = 'zenfit_habits';
  static const String keyNotifications = 'zenfit_notifications';

  // Default Goals
  static const int defaultStepGoal = 10000;
  static const int defaultCalorieGoal = 500;
  static const int defaultActiveMinGoal = 45;
  static const double defaultWaterGoal = 2.5; // Liters
  static const int defaultDailyCalorieIntake = 2200; // kcal
}

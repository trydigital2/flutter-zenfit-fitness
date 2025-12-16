import 'package:get/get.dart';
import 'app_routes.dart';
import '../../features/splash/screens/splash_screen.dart';
import '../../features/onboarding/screens/onboarding_screen.dart';
import '../../features/navigation/screens/main_navigation_screen.dart';
import '../../features/workout_details/screens/workout_details_screen.dart';
import '../../features/active_workout/screens/active_workout_screen.dart';
import '../../features/wellness/screens/breathing_exercise_screen.dart';
import '../../features/progress/screens/progress_screen.dart';
import '../../features/goals/screens/goals_habits_screen.dart';
import '../../features/favorites/screens/favorites_screen.dart';
import '../../features/notifications/screens/notifications_screen.dart';
import '../../features/search/screens/global_search_screen.dart';

class AppPages {
  AppPages._();

  static const initial = AppRoutes.splash;

  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => const MainNavigationScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.workoutDetails,
      page: () => const WorkoutDetailsScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.activeWorkout,
      page: () => const ActiveWorkoutScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: AppRoutes.breathing,
      page: () => const BreathingExerciseScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: AppRoutes.progress,
      page: () => const ProgressScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.goals,
      page: () => const GoalsHabitsScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.favorites,
      page: () => const FavoritesScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationsScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.search,
      page: () => const GlobalSearchScreen(),
      transition: Transition.fadeIn,
    ),
  ];
}

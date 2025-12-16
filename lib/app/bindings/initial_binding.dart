import 'package:get/get.dart';
import '../../core/services/storage_service.dart';
import '../../data/repositories/workout_repository.dart';
import '../../data/repositories/nutrition_repository.dart';
import '../../data/repositories/wellness_repository.dart';
import '../../data/repositories/user_repository.dart';
import '../../data/repositories/activity_repository.dart';
import '../../features/navigation/controllers/navigation_controller.dart';
import '../../features/home/controllers/home_controller.dart';
import '../../features/workouts/controllers/workout_controller.dart';
import '../../features/nutrition/controllers/nutrition_controller.dart';
import '../../features/wellness/controllers/wellness_controller.dart';
import '../../features/profile/controllers/profile_controller.dart';
import '../../features/favorites/controllers/favorites_controller.dart';
import '../../features/goals/controllers/goals_controller.dart';
import '../../features/notifications/controllers/notifications_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Repositories
    final storage = Get.find<StorageService>();
    Get.lazyPut<WorkoutRepository>(
      () => WorkoutRepository(storage),
      fenix: true,
    );
    Get.lazyPut<NutritionRepository>(
      () => NutritionRepository(storage),
      fenix: true,
    );
    Get.lazyPut<WellnessRepository>(
      () => WellnessRepository(storage),
      fenix: true,
    );
    Get.lazyPut<UserRepository>(() => UserRepository(storage), fenix: true);
    Get.lazyPut<ActivityRepository>(
      () => ActivityRepository(storage),
      fenix: true,
    );

    // Controllers
    Get.lazyPut<NavigationController>(
      () => NavigationController(),
      fenix: true,
    );
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<WorkoutController>(() => WorkoutController(), fenix: true);
    Get.lazyPut<NutritionController>(() => NutritionController(), fenix: true);
    Get.lazyPut<WellnessController>(() => WellnessController(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
    Get.lazyPut<FavoritesController>(() => FavoritesController(), fenix: true);
    Get.lazyPut<GoalsController>(() => GoalsController(), fenix: true);
    Get.lazyPut<NotificationsController>(
      () => NotificationsController(),
      fenix: true,
    );
  }
}

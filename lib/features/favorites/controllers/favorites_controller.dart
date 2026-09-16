import 'package:get/get.dart';
import '../../../data/models/workout_model.dart';
import '../../../data/models/wellness_model.dart';
import '../../../data/repositories/workout_repository.dart';
import '../../../data/repositories/wellness_repository.dart';
import '../../workouts/controllers/workout_controller.dart';
import '../../wellness/controllers/wellness_controller.dart';

class FavoritesController extends GetxController {
  final WorkoutRepository _workoutRepo = Get.find<WorkoutRepository>();
  final WellnessRepository _wellnessRepo = Get.find<WellnessRepository>();

  final favoriteWorkouts = <WorkoutModel>[].obs;
  final favoriteMeditations = <WellnessModel>[].obs;
  final selectedTab = 0.obs; // 0: Workouts, 1: Meditations

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  void loadFavorites() {
    favoriteWorkouts.value = _workoutRepo.getFavoriteWorkouts();
    favoriteMeditations.value = _wellnessRepo.getFavoriteSessions();
  }

  Future<void> removeWorkoutFavorite(String id) async {
    await _workoutRepo.toggleFavorite(id);
    favoriteWorkouts.value = _workoutRepo.getFavoriteWorkouts();
    if (Get.isRegistered<WorkoutController>()) {
      Get.find<WorkoutController>().favoriteIds.remove(id);
    }
  }

  Future<void> removeMeditationFavorite(String id) async {
    await _wellnessRepo.toggleFavorite(id);
    favoriteMeditations.value = _wellnessRepo.getFavoriteSessions();
    if (Get.isRegistered<WellnessController>()) {
      Get.find<WellnessController>().favoriteIds.remove(id);
    }
  }
}

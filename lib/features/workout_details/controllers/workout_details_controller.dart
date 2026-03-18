import 'package:get/get.dart';
import '../../../data/models/workout_model.dart';
import '../../../data/repositories/workout_repository.dart';
import '../../workouts/controllers/workout_controller.dart';

class WorkoutDetailsController extends GetxController {
  final WorkoutRepository _workoutRepo = Get.find<WorkoutRepository>();

  late WorkoutModel workout;
  final isFavorite = false.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is WorkoutModel) {
      workout = args;
    } else {
      workout = _workoutRepo.getAllWorkouts().first;
    }
    isFavorite.value = _workoutRepo.isFavorite(workout.id);
  }

  Future<void> toggleFavorite() async {
    await _workoutRepo.toggleFavorite(workout.id);
    isFavorite.value = _workoutRepo.isFavorite(workout.id);
    // sync with WorkoutController if active
    if (Get.isRegistered<WorkoutController>()) {
      final wCtrl = Get.find<WorkoutController>();
      if (isFavorite.value) {
        wCtrl.favoriteIds.add(workout.id);
      } else {
        wCtrl.favoriteIds.remove(workout.id);
      }
    }
  }
}

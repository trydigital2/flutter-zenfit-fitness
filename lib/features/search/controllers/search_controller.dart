import 'package:get/get.dart';
import '../../../data/models/workout_model.dart';
import '../../../data/models/food_item_model.dart';
import '../../../data/models/wellness_model.dart';
import '../../../data/repositories/workout_repository.dart';
import '../../../data/repositories/nutrition_repository.dart';
import '../../../data/repositories/wellness_repository.dart';

enum SearchTab { all, workouts, foods, wellness }

class GlobalSearchController extends GetxController {
  final WorkoutRepository _workoutRepo = Get.find<WorkoutRepository>();
  final NutritionRepository _nutritionRepo = Get.find<NutritionRepository>();
  final WellnessRepository _wellnessRepo = Get.find<WellnessRepository>();

  final searchQuery = ''.obs;
  final currentTab = SearchTab.all.obs;

  final matchingWorkouts = <WorkoutModel>[].obs;
  final matchingFoods = <FoodItemModel>[].obs;
  final matchingWellness = <WellnessModel>[].obs;

  void onQueryChanged(String query) {
    searchQuery.value = query;
    _performSearch();
  }

  void onTabChanged(SearchTab tab) {
    currentTab.value = tab;
  }

  void _performSearch() {
    final q = searchQuery.value.trim().toLowerCase();
    if (q.isEmpty) {
      matchingWorkouts.clear();
      matchingFoods.clear();
      matchingWellness.clear();
      return;
    }

    matchingWorkouts.value = _workoutRepo.filterWorkouts(searchQuery: q);
    matchingFoods.value = _nutritionRepo.filterFoods(searchQuery: q);
    matchingWellness.value = _wellnessRepo.filterSessions(searchQuery: q);
  }

  int get totalResultsCount =>
      matchingWorkouts.length + matchingFoods.length + matchingWellness.length;
}

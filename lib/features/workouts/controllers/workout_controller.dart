import 'package:get/get.dart';
import '../../../data/models/workout_model.dart';
import '../../../data/repositories/workout_repository.dart';

class WorkoutController extends GetxController {
  final WorkoutRepository _workoutRepo = Get.find<WorkoutRepository>();

  final searchQuery = ''.obs;
  final selectedCategory = 'All'.obs;
  final selectedDifficulty = Rxn<WorkoutDifficulty>();
  final filteredWorkouts = <WorkoutModel>[].obs;
  final favoriteIds = <String>{}.obs;

  final categories = [
    'All',
    'HIIT',
    'Strength',
    'Yoga',
    'Cardio',
    'Core',
    'Stretching',
  ];

  @override
  void onInit() {
    super.onInit();
    favoriteIds.addAll(_workoutRepo.getFavoriteIds());
    applyFilters();
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;
    applyFilters();
  }

  void onCategorySelected(String category) {
    selectedCategory.value = category;
    applyFilters();
  }

  void onDifficultySelected(WorkoutDifficulty? difficulty) {
    selectedDifficulty.value = difficulty;
    applyFilters();
  }

  void clearFilters() {
    searchQuery.value = '';
    selectedCategory.value = 'All';
    selectedDifficulty.value = null;
    applyFilters();
  }

  void applyFilters() {
    filteredWorkouts.value = _workoutRepo.filterWorkouts(
      category: selectedCategory.value,
      difficulty: selectedDifficulty.value,
      searchQuery: searchQuery.value,
    );
  }

  bool isFavorite(String id) => favoriteIds.contains(id);

  Future<void> toggleFavorite(String id) async {
    await _workoutRepo.toggleFavorite(id);
    if (favoriteIds.contains(id)) {
      favoriteIds.remove(id);
    } else {
      favoriteIds.add(id);
    }
  }

  List<WorkoutModel> get featuredWorkouts => _workoutRepo.getFeaturedWorkouts();
}

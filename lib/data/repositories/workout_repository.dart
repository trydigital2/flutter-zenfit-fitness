import '../models/workout_model.dart';
import '../models/workout_history_model.dart';
import '../mock/mock_workouts.dart';
import '../mock/mock_activity.dart';
import '../../core/services/storage_service.dart';

class WorkoutRepository {
  final StorageService _storage;

  WorkoutRepository(this._storage);

  List<WorkoutModel> getAllWorkouts() {
    return MockWorkouts.workouts;
  }

  WorkoutModel? getWorkoutById(String id) {
    try {
      return MockWorkouts.workouts.firstWhere((w) => w.id == id);
    } catch (_) {
      return null;
    }
  }

  List<WorkoutModel> getFeaturedWorkouts() {
    return MockWorkouts.workouts.where((w) => w.isFeatured).toList();
  }

  List<WorkoutModel> filterWorkouts({
    String? category,
    WorkoutDifficulty? difficulty,
    String? searchQuery,
  }) {
    return MockWorkouts.workouts.where((w) {
      if (category != null &&
          category.isNotEmpty &&
          category.toLowerCase() != 'all' &&
          w.category.toLowerCase() != category.toLowerCase()) {
        return false;
      }
      if (difficulty != null && w.difficulty != difficulty) {
        return false;
      }
      if (searchQuery != null && searchQuery.trim().isNotEmpty) {
        final q = searchQuery.toLowerCase().trim();
        final matchesTitle = w.title.toLowerCase().contains(q);
        final matchesDesc = w.description.toLowerCase().contains(q);
        final matchesCategory = w.category.toLowerCase().contains(q);
        final matchesTarget = w.targetMuscles.any(
          (m) => m.toLowerCase().contains(q),
        );
        if (!matchesTitle &&
            !matchesDesc &&
            !matchesCategory &&
            !matchesTarget) {
          return false;
        }
      }
      return true;
    }).toList();
  }

  List<String> getFavoriteIds() {
    return _storage.getFavoriteWorkoutIds();
  }

  Future<void> toggleFavorite(String workoutId) async {
    final list = _storage.getFavoriteWorkoutIds();
    if (list.contains(workoutId)) {
      list.remove(workoutId);
    } else {
      list.add(workoutId);
    }
    await _storage.saveFavoriteWorkoutIds(list);
  }

  bool isFavorite(String workoutId) {
    return _storage.getFavoriteWorkoutIds().contains(workoutId);
  }

  List<WorkoutModel> getFavoriteWorkouts() {
    final favIds = getFavoriteIds();
    return MockWorkouts.workouts.where((w) => favIds.contains(w.id)).toList();
  }

  List<WorkoutHistoryModel> getWorkoutHistory() {
    final saved = _storage.getWorkoutHistory();
    if (saved != null) return saved;
    final initial = MockActivity.getInitialWorkoutHistory();
    _storage.saveWorkoutHistory(initial);
    return initial;
  }

  Future<void> logCompletedWorkout(WorkoutHistoryModel historyItem) async {
    final history = getWorkoutHistory();
    history.insert(0, historyItem);
    await _storage.saveWorkoutHistory(history);
  }
}

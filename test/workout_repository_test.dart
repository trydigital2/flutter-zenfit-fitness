import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenfit/core/services/storage_service.dart';
import 'package:zenfit/data/models/workout_model.dart';
import 'package:zenfit/data/repositories/workout_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late StorageService storageService;
  late WorkoutRepository workoutRepo;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    storageService = await StorageService().init();
    workoutRepo = WorkoutRepository(storageService);
  });

  group('Workout Filtering & Search Tests', () {
    test('getAllWorkouts returns at least 20 mock workouts', () {
      final workouts = workoutRepo.getAllWorkouts();
      expect(workouts.length, greaterThanOrEqualTo(20));
    });

    test('filter by Category HIIT returns only HIIT routines', () {
      final hiitWorkouts = workoutRepo.filterWorkouts(category: 'HIIT');
      expect(hiitWorkouts.isNotEmpty, true);
      for (final w in hiitWorkouts) {
        expect(w.category.toLowerCase(), 'hiit');
      }
    });

    test('filter by Difficulty Beginner returns only Beginner routines', () {
      final beginnerWorkouts = workoutRepo.filterWorkouts(
        difficulty: WorkoutDifficulty.beginner,
      );
      expect(beginnerWorkouts.isNotEmpty, true);
      for (final w in beginnerWorkouts) {
        expect(w.difficulty, WorkoutDifficulty.beginner);
      }
    });

    test('filter by Search Query matches workout title or muscle', () {
      final queryResults = workoutRepo.filterWorkouts(searchQuery: 'Yoga');
      expect(queryResults.isNotEmpty, true);
      for (final w in queryResults) {
        final matches =
            w.title.toLowerCase().contains('yoga') ||
            w.category.toLowerCase().contains('yoga') ||
            w.description.toLowerCase().contains('yoga');
        expect(matches, true);
      }
    });

    test('Favorites toggling persists in storage', () async {
      const testId = 'w_01';
      expect(workoutRepo.isFavorite(testId), false);

      await workoutRepo.toggleFavorite(testId);
      expect(workoutRepo.isFavorite(testId), true);
      expect(workoutRepo.getFavoriteIds(), contains(testId));

      await workoutRepo.toggleFavorite(testId);
      expect(workoutRepo.isFavorite(testId), false);
    });
  });
}

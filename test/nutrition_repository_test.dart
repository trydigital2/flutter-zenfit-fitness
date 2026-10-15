import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenfit/core/services/storage_service.dart';
import 'package:zenfit/data/models/meal_model.dart';
import 'package:zenfit/data/mock/mock_foods.dart';
import 'package:zenfit/data/repositories/nutrition_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late StorageService storageService;
  late NutritionRepository nutritionRepo;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    storageService = await StorageService().init();
    nutritionRepo = NutritionRepository(storageService);
  });

  group('Nutrition Calculations Tests', () {
    test('getAllFoods returns at least 20 food items', () {
      final foods = nutritionRepo.getAllFoods();
      expect(foods.length, greaterThanOrEqualTo(20));
    });

    test(
      'calculateDailyTotals accurately sums calories, protein, carbs, and fat',
      () {
        final sampleMeal1 = MealModel(
          id: 'test_1',
          name: 'Meal 1',
          mealType: MealType.breakfast,
          calories: 300,
          proteinGrams: 20.0,
          carbsGrams: 40.0,
          fatGrams: 5.0,
          loggedAt: DateTime.now(),
          items: [MockFoods.foods[0]],
        );

        final sampleMeal2 = MealModel(
          id: 'test_2',
          name: 'Meal 2',
          mealType: MealType.lunch,
          calories: 500,
          proteinGrams: 45.0,
          carbsGrams: 30.0,
          fatGrams: 15.0,
          loggedAt: DateTime.now(),
          items: [MockFoods.foods[2]],
        );

        final totals = nutritionRepo.calculateDailyTotals([
          sampleMeal1,
          sampleMeal2,
        ]);

        expect(totals.totalCalories, 800);
        expect(totals.totalProtein, 65.0);
        expect(totals.totalCarbs, 70.0);
        expect(totals.totalFat, 20.0);
      },
    );

    test('food search filtering by name and category works correctly', () {
      final proteinFoods = nutritionRepo.filterFoods(category: 'Protein');
      expect(proteinFoods.isNotEmpty, true);
      for (final f in proteinFoods) {
        expect(f.category, 'Protein');
      }

      final eggSearch = nutritionRepo.filterFoods(searchQuery: 'Egg');
      expect(eggSearch.isNotEmpty, true);
      expect(eggSearch.first.name.contains('Egg'), true);
    });
  });
}

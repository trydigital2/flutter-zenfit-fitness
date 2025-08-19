import '../models/food_item_model.dart';
import '../models/meal_model.dart';
import '../mock/mock_foods.dart';
import '../mock/mock_meals.dart';
import '../../core/services/storage_service.dart';

class DailyNutritionTotals {
  final int totalCalories;
  final double totalProtein;
  final double totalCarbs;
  final double totalFat;

  const DailyNutritionTotals({
    required this.totalCalories,
    required this.totalProtein,
    required this.totalCarbs,
    required this.totalFat,
  });
}

class NutritionRepository {
  final StorageService _storage;

  NutritionRepository(this._storage);

  List<FoodItemModel> getAllFoods() {
    return MockFoods.foods;
  }

  List<FoodItemModel> filterFoods({String? category, String? searchQuery}) {
    return MockFoods.foods.where((f) {
      if (category != null &&
          category.isNotEmpty &&
          category.toLowerCase() != 'all' &&
          f.category.toLowerCase() != category.toLowerCase()) {
        return false;
      }
      if (searchQuery != null && searchQuery.trim().isNotEmpty) {
        final q = searchQuery.toLowerCase().trim();
        final matchesName = f.name.toLowerCase().contains(q);
        final matchesCat = f.category.toLowerCase().contains(q);
        if (!matchesName && !matchesCat) {
          return false;
        }
      }
      return true;
    }).toList();
  }

  List<MealModel> getLoggedMeals() {
    final saved = _storage.getLoggedMeals();
    if (saved != null) return saved;
    final initial = MockMeals.defaultLoggedMeals;
    _storage.saveLoggedMeals(initial);
    return initial;
  }

  Future<void> logMeal(MealModel meal) async {
    final list = getLoggedMeals();
    list.insert(0, meal);
    await _storage.saveLoggedMeals(list);
  }

  Future<void> removeMeal(String mealId) async {
    final list = getLoggedMeals();
    list.removeWhere((m) => m.id == mealId);
    await _storage.saveLoggedMeals(list);
  }

  DailyNutritionTotals calculateDailyTotals(List<MealModel> meals) {
    int calories = 0;
    double protein = 0;
    double carbs = 0;
    double fat = 0;

    for (final meal in meals) {
      calories += meal.calories;
      protein += meal.proteinGrams;
      carbs += meal.carbsGrams;
      fat += meal.fatGrams;
    }

    return DailyNutritionTotals(
      totalCalories: calories,
      totalProtein: protein,
      totalCarbs: carbs,
      totalFat: fat,
    );
  }

  List<MealModel> getSampleTemplates() {
    return MockMeals.sampleMealTemplates;
  }
}

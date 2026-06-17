import 'package:get/get.dart';
import '../../../data/models/food_item_model.dart';
import '../../../data/models/meal_model.dart';
import '../../../data/repositories/nutrition_repository.dart';
import '../../../data/repositories/activity_repository.dart';
import '../../../core/constants/app_constants.dart';

class NutritionController extends GetxController {
  final NutritionRepository _nutritionRepo = Get.find<NutritionRepository>();
  final ActivityRepository _activityRepo = Get.find<ActivityRepository>();

  final loggedMeals = <MealModel>[].obs;
  final allFoods = <FoodItemModel>[].obs;
  final searchResults = <FoodItemModel>[].obs;
  final selectedFoodCategory = 'All'.obs;
  final foodSearchQuery = ''.obs;

  final dailyCalorieTarget = AppConstants.defaultDailyCalorieIntake;
  final dailyProteinTarget = 140.0; // grams
  final dailyCarbsTarget = 240.0; // grams
  final dailyFatTarget = 65.0; // grams

  final foodCategories = [
    'All',
    'Protein',
    'Grains',
    'Vegetables',
    'Fruits',
    'Dairy',
    'Healthy Fats',
  ];

  @override
  void onInit() {
    super.onInit();
    allFoods.value = _nutritionRepo.getAllFoods();
    loggedMeals.value = _nutritionRepo.getLoggedMeals();
    applyFoodFilters();
  }

  void onFoodSearchChanged(String query) {
    foodSearchQuery.value = query;
    applyFoodFilters();
  }

  void onFoodCategorySelected(String category) {
    selectedFoodCategory.value = category;
    applyFoodFilters();
  }

  void applyFoodFilters() {
    searchResults.value = _nutritionRepo.filterFoods(
      category: selectedFoodCategory.value,
      searchQuery: foodSearchQuery.value,
    );
  }

  // Calculated totals
  DailyNutritionTotals get dailyTotals =>
      _nutritionRepo.calculateDailyTotals(loggedMeals);

  int get caloriesConsumed => dailyTotals.totalCalories;
  int get caloriesRemaining =>
      (dailyCalorieTarget - caloriesConsumed).clamp(0, dailyCalorieTarget);

  double get calorieProgress =>
      (caloriesConsumed / dailyCalorieTarget).clamp(0.0, 1.0);
  double get proteinProgress =>
      (dailyTotals.totalProtein / dailyProteinTarget).clamp(0.0, 1.0);
  double get carbsProgress =>
      (dailyTotals.totalCarbs / dailyCarbsTarget).clamp(0.0, 1.0);
  double get fatProgress =>
      (dailyTotals.totalFat / dailyFatTarget).clamp(0.0, 1.0);

  List<MealModel> getMealsByType(MealType type) {
    return loggedMeals.where((m) => m.mealType == type).toList();
  }

  Future<void> logNewMeal({
    required String name,
    required MealType mealType,
    required List<FoodItemModel> items,
  }) async {
    int totalCals = 0;
    double totalP = 0;
    double totalC = 0;
    double totalF = 0;

    for (final item in items) {
      totalCals += item.calories;
      totalP += item.proteinGrams;
      totalC += item.carbsGrams;
      totalF += item.fatGrams;
    }

    final newMeal = MealModel(
      id: 'meal_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      mealType: mealType,
      calories: totalCals,
      proteinGrams: totalP,
      carbsGrams: totalC,
      fatGrams: totalF,
      imageUrl: items.isNotEmpty ? items.first.imageUrl : '',
      loggedAt: DateTime.now(),
      items: items,
    );

    await _nutritionRepo.logMeal(newMeal);
    loggedMeals.value = _nutritionRepo.getLoggedMeals();
  }

  Future<void> logSampleTemplate(MealModel template) async {
    final cloned = MealModel(
      id: 'meal_${DateTime.now().millisecondsSinceEpoch}',
      name: template.name,
      mealType: template.mealType,
      calories: template.calories,
      proteinGrams: template.proteinGrams,
      carbsGrams: template.carbsGrams,
      fatGrams: template.fatGrams,
      imageUrl: template.imageUrl,
      loggedAt: DateTime.now(),
      items: template.items,
    );

    await _nutritionRepo.logMeal(cloned);
    loggedMeals.value = _nutritionRepo.getLoggedMeals();
  }

  Future<void> removeMeal(String mealId) async {
    await _nutritionRepo.removeMeal(mealId);
    loggedMeals.value = _nutritionRepo.getLoggedMeals();
  }

  double get currentWaterLiters => _activityRepo.getTodayActivity().waterLiters;

  Future<void> addWater() async {
    await _activityRepo.addWater(0.25);
    update();
  }

  List<MealModel> getSampleTemplates() => _nutritionRepo.getSampleTemplates();
}

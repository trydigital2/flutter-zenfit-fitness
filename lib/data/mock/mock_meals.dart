import '../models/meal_model.dart';
import 'mock_foods.dart';

class MockMeals {
  MockMeals._();

  static final List<MealModel> defaultLoggedMeals = [
    MealModel(
      id: 'meal_01',
      name: 'Power Protein Oatmeal Bowl',
      mealType: MealType.breakfast,
      calories: 460,
      proteinGrams: 32.0,
      carbsGrams: 60.0,
      fatGrams: 7.0,
      imageUrl:
          'https://images.unsplash.com/photo-1584776296944-ab6fb57b0bdd?w=500&auto=format&fit=crop&q=80',
      loggedAt: DateTime.now().subtract(const Duration(hours: 4)),
      items: [
        MockFoods.foods[0], // Steel Cut Oatmeal
        MockFoods.foods[7], // Fresh Blueberries
        MockFoods.foods[9], // Whey Protein
      ],
    ),
    MealModel(
      id: 'meal_02',
      name: 'Grilled Salmon & Quinoa Bowl',
      mealType: MealType.lunch,
      calories: 615,
      proteinGrams: 49.0,
      carbsGrams: 49.0,
      fatGrams: 24.0,
      imageUrl:
          'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=500&auto=format&fit=crop&q=80',
      loggedAt: DateTime.now().subtract(const Duration(hours: 1)),
      items: [
        MockFoods.foods[4], // Salmon
        MockFoods.foods[5], // Quinoa
        MockFoods.foods[8], // Broccoli
      ],
    ),
  ];

  static final List<MealModel> sampleMealTemplates = [
    MealModel(
      id: 'template_01',
      name: 'Avocado Egg Sourdough Toast',
      mealType: MealType.breakfast,
      calories: 404,
      proteinGrams: 19.1,
      carbsGrams: 26.8,
      fatGrams: 24.8,
      imageUrl:
          'https://images.unsplash.com/photo-1588137378633-dea1336ce1e2?w=500&auto=format&fit=crop&q=80',
      loggedAt: DateTime.now(),
      items: [MockFoods.foods[3], MockFoods.foods[6]],
    ),
    MealModel(
      id: 'template_02',
      name: 'Herb-Roasted Chicken & Sweet Potato',
      mealType: MealType.dinner,
      calories: 500,
      proteinGrams: 51.5,
      carbsGrams: 35.0,
      fatGrams: 16.4,
      imageUrl:
          'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d?w=500&auto=format&fit=crop&q=80',
      loggedAt: DateTime.now(),
      items: [MockFoods.foods[2], MockFoods.foods[10], MockFoods.foods[14]],
    ),
    MealModel(
      id: 'template_03',
      name: 'Greek Yogurt Berry Parfait',
      mealType: MealType.snack,
      calories: 214,
      proteinGrams: 23.1,
      carbsGrams: 29.4,
      fatGrams: 1.0,
      imageUrl:
          'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=500&auto=format&fit=crop&q=80',
      loggedAt: DateTime.now(),
      items: [MockFoods.foods[1], MockFoods.foods[7]],
    ),
    MealModel(
      id: 'template_04',
      name: 'Pan-Seared Tofu & Brown Jasmine Rice',
      mealType: MealType.dinner,
      calories: 433,
      proteinGrams: 25.0,
      carbsGrams: 53.3,
      fatGrams: 11.2,
      imageUrl:
          'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=500&auto=format&fit=crop&q=80',
      loggedAt: DateTime.now(),
      items: [MockFoods.foods[13], MockFoods.foods[18], MockFoods.foods[8]],
    ),
    MealModel(
      id: 'template_05',
      name: 'Almonds & Dark Chocolate Energy Pack',
      mealType: MealType.snack,
      calories: 305,
      proteinGrams: 8.0,
      carbsGrams: 15.0,
      fatGrams: 26.5,
      imageUrl:
          'https://images.unsplash.com/photo-1508061253366-f7da158b6d46?w=500&auto=format&fit=crop&q=80',
      loggedAt: DateTime.now(),
      items: [MockFoods.foods[11], MockFoods.foods[20]],
    ),
    MealModel(
      id: 'template_06',
      name: 'Cottage Cheese & Sliced Banana',
      mealType: MealType.snack,
      calories: 268,
      proteinGrams: 29.3,
      carbsGrams: 33.2,
      fatGrams: 2.6,
      imageUrl:
          'https://images.unsplash.com/photo-1528750997573-59b89d56f4f7?w=500&auto=format&fit=crop&q=80',
      loggedAt: DateTime.now(),
      items: [MockFoods.foods[16], MockFoods.foods[15]],
    ),
    MealModel(
      id: 'template_07',
      name: 'Chia Seed Pudding with Matcha',
      mealType: MealType.breakfast,
      calories: 305,
      proteinGrams: 8.5,
      carbsGrams: 34.0,
      fatGrams: 15.0,
      imageUrl:
          'https://images.unsplash.com/photo-1511690656952-34342bb7c2f2?w=500&auto=format&fit=crop&q=80',
      loggedAt: DateTime.now(),
      items: [MockFoods.foods[12], MockFoods.foods[19]],
    ),
    MealModel(
      id: 'template_08',
      name: 'Mediterranean Hummus & Veggie Platter',
      mealType: MealType.lunch,
      calories: 295,
      proteinGrams: 7.3,
      carbsGrams: 23.0,
      fatGrams: 20.2,
      imageUrl:
          'https://images.unsplash.com/photo-1505576399279-565b52d4ac71?w=500&auto=format&fit=crop&q=80',
      loggedAt: DateTime.now(),
      items: [MockFoods.foods[17], MockFoods.foods[14]],
    ),
  ];
}

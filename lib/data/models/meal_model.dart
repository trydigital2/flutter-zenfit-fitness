import 'food_item_model.dart';

enum MealType {
  breakfast,
  lunch,
  dinner,
  snack;

  String get displayName {
    switch (this) {
      case MealType.breakfast:
        return 'Breakfast';
      case MealType.lunch:
        return 'Lunch';
      case MealType.dinner:
        return 'Dinner';
      case MealType.snack:
        return 'Snack';
    }
  }

  static MealType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'breakfast':
        return MealType.breakfast;
      case 'lunch':
        return MealType.lunch;
      case 'dinner':
        return MealType.dinner;
      case 'snack':
      default:
        return MealType.snack;
    }
  }
}

class MealModel {
  final String id;
  final String name;
  final MealType mealType;
  final int calories;
  final double proteinGrams;
  final double carbsGrams;
  final double fatGrams;
  final String imageUrl;
  final DateTime loggedAt;
  final List<FoodItemModel> items;

  const MealModel({
    required this.id,
    required this.name,
    required this.mealType,
    required this.calories,
    required this.proteinGrams,
    required this.carbsGrams,
    required this.fatGrams,
    this.imageUrl = '',
    required this.loggedAt,
    this.items = const [],
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'mealType': mealType.displayName,
    'calories': calories,
    'proteinGrams': proteinGrams,
    'carbsGrams': carbsGrams,
    'fatGrams': fatGrams,
    'imageUrl': imageUrl,
    'loggedAt': loggedAt.toIso8601String(),
    'items': items.map((e) => e.toJson()).toList(),
  };

  factory MealModel.fromJson(Map<String, dynamic> json) => MealModel(
    id: json['id'] as String,
    name: json['name'] as String,
    mealType: MealType.fromString(json['mealType'] as String? ?? 'Breakfast'),
    calories: (json['calories'] as num).toInt(),
    proteinGrams: (json['proteinGrams'] as num).toDouble(),
    carbsGrams: (json['carbsGrams'] as num).toDouble(),
    fatGrams: (json['fatGrams'] as num).toDouble(),
    imageUrl: json['imageUrl'] as String? ?? '',
    loggedAt:
        DateTime.tryParse(json['loggedAt'] as String? ?? '') ?? DateTime.now(),
    items:
        (json['items'] as List<dynamic>?)
            ?.map((e) => FoodItemModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}

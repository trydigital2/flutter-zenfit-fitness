class FoodItemModel {
  final String id;
  final String name;
  final String
  category; // Fruits, Protein, Grains, Dairy, Vegetables, Healthy Fats
  final String servingSize;
  final int calories;
  final double proteinGrams;
  final double carbsGrams;
  final double fatGrams;
  final String imageUrl;

  const FoodItemModel({
    required this.id,
    required this.name,
    required this.category,
    required this.servingSize,
    required this.calories,
    required this.proteinGrams,
    required this.carbsGrams,
    required this.fatGrams,
    this.imageUrl = '',
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'category': category,
    'servingSize': servingSize,
    'calories': calories,
    'proteinGrams': proteinGrams,
    'carbsGrams': carbsGrams,
    'fatGrams': fatGrams,
    'imageUrl': imageUrl,
  };

  factory FoodItemModel.fromJson(Map<String, dynamic> json) => FoodItemModel(
    id: json['id'] as String,
    name: json['name'] as String,
    category: json['category'] as String,
    servingSize: json['servingSize'] as String,
    calories: (json['calories'] as num).toInt(),
    proteinGrams: (json['proteinGrams'] as num).toDouble(),
    carbsGrams: (json['carbsGrams'] as num).toDouble(),
    fatGrams: (json['fatGrams'] as num).toDouble(),
    imageUrl: json['imageUrl'] as String? ?? '',
  );
}

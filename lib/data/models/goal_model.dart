enum GoalType {
  steps,
  calories,
  water,
  activeMinutes;

  String get displayName {
    switch (this) {
      case GoalType.steps:
        return 'Daily Steps';
      case GoalType.calories:
        return 'Calorie Burn';
      case GoalType.water:
        return 'Hydration';
      case GoalType.activeMinutes:
        return 'Active Minutes';
    }
  }

  String get unit {
    switch (this) {
      case GoalType.steps:
        return 'steps';
      case GoalType.calories:
        return 'kcal';
      case GoalType.water:
        return 'L';
      case GoalType.activeMinutes:
        return 'min';
    }
  }
}

class GoalModel {
  final String id;
  final GoalType type;
  final String title;
  final double targetValue;
  final double currentValue;
  final String unit;

  const GoalModel({
    required this.id,
    required this.type,
    required this.title,
    required this.targetValue,
    required this.currentValue,
    required this.unit,
  });

  double get progressPercentage =>
      targetValue <= 0 ? 0 : (currentValue / targetValue).clamp(0.0, 1.0);

  bool get isCompleted => currentValue >= targetValue;

  GoalModel copyWith({
    String? id,
    GoalType? type,
    String? title,
    double? targetValue,
    double? currentValue,
    String? unit,
  }) => GoalModel(
    id: id ?? this.id,
    type: type ?? this.type,
    title: title ?? this.title,
    targetValue: targetValue ?? this.targetValue,
    currentValue: currentValue ?? this.currentValue,
    unit: unit ?? this.unit,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type.name,
    'title': title,
    'targetValue': targetValue,
    'currentValue': currentValue,
    'unit': unit,
  };

  factory GoalModel.fromJson(Map<String, dynamic> json) => GoalModel(
    id: json['id'] as String,
    type: GoalType.values.firstWhere(
      (t) => t.name == json['type'],
      orElse: () => GoalType.steps,
    ),
    title: json['title'] as String,
    targetValue: (json['targetValue'] as num).toDouble(),
    currentValue: (json['currentValue'] as num).toDouble(),
    unit: json['unit'] as String,
  );
}

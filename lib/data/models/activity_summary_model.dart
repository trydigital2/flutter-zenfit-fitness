class ActivitySummaryModel {
  final DateTime date;
  final int steps;
  final int calories;
  final int activeMinutes;
  final double waterLiters;
  final int targetSteps;
  final int targetCalories;
  final int targetActiveMinutes;
  final double targetWaterLiters;

  const ActivitySummaryModel({
    required this.date,
    required this.steps,
    required this.calories,
    required this.activeMinutes,
    required this.waterLiters,
    this.targetSteps = 10000,
    this.targetCalories = 500,
    this.targetActiveMinutes = 45,
    this.targetWaterLiters = 2.5,
  });

  double get stepProgress =>
      targetSteps <= 0 ? 0.0 : (steps / targetSteps).clamp(0.0, 1.0);
  double get calorieProgress =>
      targetCalories <= 0 ? 0.0 : (calories / targetCalories).clamp(0.0, 1.0);
  double get activeMinuteProgress => targetActiveMinutes <= 0
      ? 0.0
      : (activeMinutes / targetActiveMinutes).clamp(0.0, 1.0);
  double get waterProgress => targetWaterLiters <= 0
      ? 0.0
      : (waterLiters / targetWaterLiters).clamp(0.0, 1.0);

  double get overallDailyScore {
    return ((stepProgress +
                calorieProgress +
                activeMinuteProgress +
                waterProgress) /
            4 *
            100)
        .clamp(0.0, 100.0);
  }

  ActivitySummaryModel copyWith({
    DateTime? date,
    int? steps,
    int? calories,
    int? activeMinutes,
    double? waterLiters,
    int? targetSteps,
    int? targetCalories,
    int? targetActiveMinutes,
    double? targetWaterLiters,
  }) => ActivitySummaryModel(
    date: date ?? this.date,
    steps: steps ?? this.steps,
    calories: calories ?? this.calories,
    activeMinutes: activeMinutes ?? this.activeMinutes,
    waterLiters: waterLiters ?? this.waterLiters,
    targetSteps: targetSteps ?? this.targetSteps,
    targetCalories: targetCalories ?? this.targetCalories,
    targetActiveMinutes: targetActiveMinutes ?? this.targetActiveMinutes,
    targetWaterLiters: targetWaterLiters ?? this.targetWaterLiters,
  );

  Map<String, dynamic> toJson() => {
    'date': date.toIso8601String(),
    'steps': steps,
    'calories': calories,
    'activeMinutes': activeMinutes,
    'waterLiters': waterLiters,
    'targetSteps': targetSteps,
    'targetCalories': targetCalories,
    'targetActiveMinutes': targetActiveMinutes,
    'targetWaterLiters': targetWaterLiters,
  };

  factory ActivitySummaryModel.fromJson(
    Map<String, dynamic> json,
  ) => ActivitySummaryModel(
    date: DateTime.tryParse(json['date'] as String? ?? '') ?? DateTime.now(),
    steps: (json['steps'] as num?)?.toInt() ?? 0,
    calories: (json['calories'] as num?)?.toInt() ?? 0,
    activeMinutes: (json['activeMinutes'] as num?)?.toInt() ?? 0,
    waterLiters: (json['waterLiters'] as num?)?.toDouble() ?? 0.0,
    targetSteps: (json['targetSteps'] as num?)?.toInt() ?? 10000,
    targetCalories: (json['targetCalories'] as num?)?.toInt() ?? 500,
    targetActiveMinutes: (json['targetActiveMinutes'] as num?)?.toInt() ?? 45,
    targetWaterLiters: (json['targetWaterLiters'] as num?)?.toDouble() ?? 2.5,
  );
}

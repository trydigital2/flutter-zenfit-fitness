class WorkoutHistoryModel {
  final String id;
  final String workoutId;
  final String workoutTitle;
  final String category;
  final DateTime completedAt;
  final int durationMinutes;
  final int caloriesBurned;
  final int exercisesCompleted;

  const WorkoutHistoryModel({
    required this.id,
    required this.workoutId,
    required this.workoutTitle,
    required this.category,
    required this.completedAt,
    required this.durationMinutes,
    required this.caloriesBurned,
    required this.exercisesCompleted,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'workoutId': workoutId,
    'workoutTitle': workoutTitle,
    'category': category,
    'completedAt': completedAt.toIso8601String(),
    'durationMinutes': durationMinutes,
    'caloriesBurned': caloriesBurned,
    'exercisesCompleted': exercisesCompleted,
  };

  factory WorkoutHistoryModel.fromJson(Map<String, dynamic> json) =>
      WorkoutHistoryModel(
        id: json['id'] as String,
        workoutId: json['workoutId'] as String,
        workoutTitle: json['workoutTitle'] as String,
        category: json['category'] as String? ?? 'Strength',
        completedAt:
            DateTime.tryParse(json['completedAt'] as String? ?? '') ??
            DateTime.now(),
        durationMinutes: (json['durationMinutes'] as num).toInt(),
        caloriesBurned: (json['caloriesBurned'] as num).toInt(),
        exercisesCompleted: (json['exercisesCompleted'] as num?)?.toInt() ?? 5,
      );
}

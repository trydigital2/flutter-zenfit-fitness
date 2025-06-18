import 'exercise_model.dart';

enum WorkoutDifficulty {
  beginner,
  intermediate,
  advanced;

  String get displayName {
    switch (this) {
      case WorkoutDifficulty.beginner:
        return 'Beginner';
      case WorkoutDifficulty.intermediate:
        return 'Intermediate';
      case WorkoutDifficulty.advanced:
        return 'Advanced';
    }
  }

  static WorkoutDifficulty fromString(String value) {
    switch (value.toLowerCase()) {
      case 'beginner':
        return WorkoutDifficulty.beginner;
      case 'intermediate':
        return WorkoutDifficulty.intermediate;
      case 'advanced':
        return WorkoutDifficulty.advanced;
      default:
        return WorkoutDifficulty.intermediate;
    }
  }
}

class WorkoutModel {
  final String id;
  final String title;
  final String description;
  final String category; // Strength, Cardio, Yoga, HIIT, Stretching, Core
  final WorkoutDifficulty difficulty;
  final int durationMinutes;
  final int caloriesBurned;
  final String imageUrl;
  final List<String> equipment;
  final List<String> targetMuscles;
  final List<ExerciseModel> exercises;
  final bool isFeatured;
  final double rating;

  const WorkoutModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.difficulty,
    required this.durationMinutes,
    required this.caloriesBurned,
    required this.imageUrl,
    required this.equipment,
    required this.targetMuscles,
    required this.exercises,
    this.isFeatured = false,
    this.rating = 4.8,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'category': category,
    'difficulty': difficulty.displayName,
    'durationMinutes': durationMinutes,
    'caloriesBurned': caloriesBurned,
    'imageUrl': imageUrl,
    'equipment': equipment,
    'targetMuscles': targetMuscles,
    'exercises': exercises.map((e) => e.toJson()).toList(),
    'isFeatured': isFeatured,
    'rating': rating,
  };

  factory WorkoutModel.fromJson(Map<String, dynamic> json) => WorkoutModel(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    category: json['category'] as String,
    difficulty: WorkoutDifficulty.fromString(
      json['difficulty'] as String? ?? 'Intermediate',
    ),
    durationMinutes: (json['durationMinutes'] as num).toInt(),
    caloriesBurned: (json['caloriesBurned'] as num).toInt(),
    imageUrl: json['imageUrl'] as String? ?? '',
    equipment:
        (json['equipment'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [],
    targetMuscles:
        (json['targetMuscles'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [],
    exercises:
        (json['exercises'] as List<dynamic>?)
            ?.map((e) => ExerciseModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
    isFeatured: json['isFeatured'] as bool? ?? false,
    rating: (json['rating'] as num?)?.toDouble() ?? 4.8,
  );
}

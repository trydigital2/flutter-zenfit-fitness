class ExerciseModel {
  final String id;
  final String name;
  final String description;
  final int durationSeconds; // 0 if rep-based
  final int reps; // 0 if timed
  final int sets;
  final int restSeconds;
  final String imageUrl;
  final String tips;

  const ExerciseModel({
    required this.id,
    required this.name,
    required this.description,
    this.durationSeconds = 0,
    this.reps = 0,
    this.sets = 3,
    this.restSeconds = 30,
    required this.imageUrl,
    this.tips = 'Maintain steady breathing and keep your core engaged.',
  });

  bool get isTimed => durationSeconds > 0;

  String get targetDisplay =>
      isTimed ? '$durationSeconds sec' : '$reps reps × $sets sets';

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'durationSeconds': durationSeconds,
    'reps': reps,
    'sets': sets,
    'restSeconds': restSeconds,
    'imageUrl': imageUrl,
    'tips': tips,
  };

  factory ExerciseModel.fromJson(Map<String, dynamic> json) => ExerciseModel(
    id: json['id'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    durationSeconds: (json['durationSeconds'] as num?)?.toInt() ?? 0,
    reps: (json['reps'] as num?)?.toInt() ?? 0,
    sets: (json['sets'] as num?)?.toInt() ?? 3,
    restSeconds: (json['restSeconds'] as num?)?.toInt() ?? 30,
    imageUrl: json['imageUrl'] as String? ?? '',
    tips: json['tips'] as String? ?? '',
  );
}

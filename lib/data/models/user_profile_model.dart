class UserProfileModel {
  final String name;
  final String email;
  final String avatarUrl;
  final int age;
  final double heightCm;
  final double weightKg;
  final String fitnessLevel; // Beginner, Intermediate, Advanced
  final String
  fitnessGoal; // Weight Loss, Muscle Build, Endurance, Flexibility, General Health
  final List<String> preferredCategories;
  final String unitSystem; // Metric, Imperial

  const UserProfileModel({
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.age,
    required this.heightCm,
    required this.weightKg,
    required this.fitnessLevel,
    required this.fitnessGoal,
    required this.preferredCategories,
    this.unitSystem = 'Metric',
  });

  double get bmi {
    if (heightCm <= 0) return 0;
    final heightM = heightCm / 100;
    return weightKg / (heightM * heightM);
  }

  String get bmiCategory {
    final value = bmi;
    if (value < 18.5) return 'Underweight';
    if (value < 25) return 'Normal Weight';
    if (value < 30) return 'Overweight';
    return 'Obese';
  }

  UserProfileModel copyWith({
    String? name,
    String? email,
    String? avatarUrl,
    int? age,
    double? heightCm,
    double? weightKg,
    String? fitnessLevel,
    String? fitnessGoal,
    List<String>? preferredCategories,
    String? unitSystem,
  }) => UserProfileModel(
    name: name ?? this.name,
    email: email ?? this.email,
    avatarUrl: avatarUrl ?? this.avatarUrl,
    age: age ?? this.age,
    heightCm: heightCm ?? this.heightCm,
    weightKg: weightKg ?? this.weightKg,
    fitnessLevel: fitnessLevel ?? this.fitnessLevel,
    fitnessGoal: fitnessGoal ?? this.fitnessGoal,
    preferredCategories: preferredCategories ?? this.preferredCategories,
    unitSystem: unitSystem ?? this.unitSystem,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'avatarUrl': avatarUrl,
    'age': age,
    'heightCm': heightCm,
    'weightKg': weightKg,
    'fitnessLevel': fitnessLevel,
    'fitnessGoal': fitnessGoal,
    'preferredCategories': preferredCategories,
    'unitSystem': unitSystem,
  };

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        name: json['name'] as String? ?? 'Alex Morgan',
        email: json['email'] as String? ?? 'alex.morgan@zenfit.app',
        avatarUrl: json['avatarUrl'] as String? ?? '',
        age: (json['age'] as num?)?.toInt() ?? 28,
        heightCm: (json['heightCm'] as num?)?.toDouble() ?? 175.0,
        weightKg: (json['weightKg'] as num?)?.toDouble() ?? 70.0,
        fitnessLevel: json['fitnessLevel'] as String? ?? 'Intermediate',
        fitnessGoal:
            json['fitnessGoal'] as String? ?? 'Muscle Tone & Endurance',
        preferredCategories:
            (json['preferredCategories'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            ['Strength', 'HIIT', 'Yoga'],
        unitSystem: json['unitSystem'] as String? ?? 'Metric',
      );
}

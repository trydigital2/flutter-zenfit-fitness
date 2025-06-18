class HabitModel {
  final String id;
  final String title;
  final String category; // Fitness, Nutrition, Mindfulness, Health
  final int iconCodePoint;
  final int colorHex;
  final List<String> completedDates; // List of 'yyyy-MM-dd'
  final int targetDaysPerWeek;

  const HabitModel({
    required this.id,
    required this.title,
    required this.category,
    required this.iconCodePoint,
    required this.colorHex,
    this.completedDates = const [],
    this.targetDaysPerWeek = 7,
  });

  bool isCompletedOn(DateTime date) {
    final key = _formatDateKey(date);
    return completedDates.contains(key);
  }

  bool get isCompletedToday => isCompletedOn(DateTime.now());

  int get currentStreak {
    int streak = 0;
    var checkDate = DateTime.now();

    // If not completed today yet, check starting yesterday for streak
    if (!isCompletedOn(checkDate)) {
      checkDate = checkDate.subtract(const Duration(days: 1));
    }

    while (isCompletedOn(checkDate)) {
      streak++;
      checkDate = checkDate.subtract(const Duration(days: 1));
    }
    return streak;
  }

  static String _formatDateKey(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  HabitModel toggleToday() {
    final todayKey = _formatDateKey(DateTime.now());
    final newDates = List<String>.from(completedDates);
    if (newDates.contains(todayKey)) {
      newDates.remove(todayKey);
    } else {
      newDates.add(todayKey);
    }
    return copyWith(completedDates: newDates);
  }

  HabitModel toggleDate(DateTime date) {
    final key = _formatDateKey(date);
    final newDates = List<String>.from(completedDates);
    if (newDates.contains(key)) {
      newDates.remove(key);
    } else {
      newDates.add(key);
    }
    return copyWith(completedDates: newDates);
  }

  HabitModel copyWith({
    String? id,
    String? title,
    String? category,
    int? iconCodePoint,
    int? colorHex,
    List<String>? completedDates,
    int? targetDaysPerWeek,
  }) => HabitModel(
    id: id ?? this.id,
    title: title ?? this.title,
    category: category ?? this.category,
    iconCodePoint: iconCodePoint ?? this.iconCodePoint,
    colorHex: colorHex ?? this.colorHex,
    completedDates: completedDates ?? this.completedDates,
    targetDaysPerWeek: targetDaysPerWeek ?? this.targetDaysPerWeek,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'category': category,
    'iconCodePoint': iconCodePoint,
    'colorHex': colorHex,
    'completedDates': completedDates,
    'targetDaysPerWeek': targetDaysPerWeek,
  };

  factory HabitModel.fromJson(Map<String, dynamic> json) => HabitModel(
    id: json['id'] as String,
    title: json['title'] as String,
    category: json['category'] as String? ?? 'Fitness',
    iconCodePoint: (json['iconCodePoint'] as num).toInt(),
    colorHex: (json['colorHex'] as num).toInt(),
    completedDates:
        (json['completedDates'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [],
    targetDaysPerWeek: (json['targetDaysPerWeek'] as num?)?.toInt() ?? 7,
  );
}

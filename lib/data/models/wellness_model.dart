class WellnessModel {
  final String id;
  final String title;
  final String description;
  final String category; // Meditation, Breathing, Sleep, Stress Relief
  final int durationMinutes;
  final String instructor;
  final String imageUrl;
  final bool isFeatured;
  final String benefits;

  const WellnessModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.durationMinutes,
    required this.instructor,
    this.imageUrl = '',
    this.isFeatured = false,
    this.benefits = 'Calms the nervous system and enhances mental clarity.',
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'category': category,
    'durationMinutes': durationMinutes,
    'instructor': instructor,
    'imageUrl': imageUrl,
    'isFeatured': isFeatured,
    'benefits': benefits,
  };

  factory WellnessModel.fromJson(Map<String, dynamic> json) => WellnessModel(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    category: json['category'] as String,
    durationMinutes: (json['durationMinutes'] as num).toInt(),
    instructor: json['instructor'] as String,
    imageUrl: json['imageUrl'] as String? ?? '',
    isFeatured: json['isFeatured'] as bool? ?? false,
    benefits: json['benefits'] as String? ?? '',
  );
}

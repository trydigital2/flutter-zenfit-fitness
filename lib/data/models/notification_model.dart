enum NotificationCategory {
  workout,
  hydration,
  goal,
  wellness;

  String get displayName {
    switch (this) {
      case NotificationCategory.workout:
        return 'Workout';
      case NotificationCategory.hydration:
        return 'Hydration';
      case NotificationCategory.goal:
        return 'Goal Achievement';
      case NotificationCategory.wellness:
        return 'Mindfulness';
    }
  }
}

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final NotificationCategory category;
  final bool isRead;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.category,
    this.isRead = false,
  });

  NotificationModel copyWith({
    String? id,
    String? title,
    String? message,
    DateTime? timestamp,
    NotificationCategory? category,
    bool? isRead,
  }) => NotificationModel(
    id: id ?? this.id,
    title: title ?? this.title,
    message: message ?? this.message,
    timestamp: timestamp ?? this.timestamp,
    category: category ?? this.category,
    isRead: isRead ?? this.isRead,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'message': message,
    'timestamp': timestamp.toIso8601String(),
    'category': category.name,
    'isRead': isRead,
  };

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json['id'] as String,
        title: json['title'] as String,
        message: json['message'] as String,
        timestamp:
            DateTime.tryParse(json['timestamp'] as String? ?? '') ??
            DateTime.now(),
        category: NotificationCategory.values.firstWhere(
          (c) => c.name == json['category'],
          orElse: () => NotificationCategory.workout,
        ),
        isRead: json['isRead'] as bool? ?? false,
      );
}

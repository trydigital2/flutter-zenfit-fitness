import '../models/notification_model.dart';

class MockNotifications {
  MockNotifications._();

  static List<NotificationModel> getDefaultNotifications() {
    final now = DateTime.now();
    return [
      NotificationModel(
        id: 'notif_01',
        title: 'Time for Today’s Workout! 🏋️',
        message:
            'Your scheduled session "Full Body HIIT Blast" is ready. Let’s crush those 320 calories!',
        timestamp: now.subtract(const Duration(minutes: 45)),
        category: NotificationCategory.workout,
        isRead: false,
      ),
      NotificationModel(
        id: 'notif_02',
        title: 'Hydration Check 💧',
        message:
            'You have logged 1.5L so far. Drink another glass to stay on track for your 2.5L goal.',
        timestamp: now.subtract(const Duration(hours: 2)),
        category: NotificationCategory.hydration,
        isRead: false,
      ),
      NotificationModel(
        id: 'notif_03',
        title: 'Streak Milestone Achieved! 🔥',
        message:
            'Congratulations! You have maintained a 7-day workout streak. Consistency is your superpower.',
        timestamp: now.subtract(const Duration(hours: 5)),
        category: NotificationCategory.goal,
        isRead: true,
      ),
      NotificationModel(
        id: 'notif_04',
        title: 'Evening Mindfulness Reminder 🧘',
        message:
            'Unwind with a 5-minute breathing session before dinner to reduce workday stress.',
        timestamp: now.subtract(const Duration(hours: 8)),
        category: NotificationCategory.wellness,
        isRead: true,
      ),
      NotificationModel(
        id: 'notif_05',
        title: 'Step Goal In Reach! 👟',
        message:
            'You reached 6,450 steps today. Just 3,550 more to achieve your 10k target.',
        timestamp: now.subtract(const Duration(hours: 14)),
        category: NotificationCategory.goal,
        isRead: true,
      ),
      NotificationModel(
        id: 'notif_06',
        title: 'New Workout Added ✨',
        message:
            'Check out "Power Yoga for Athletes" now available in your workout library.',
        timestamp: now.subtract(const Duration(days: 1, hours: 3)),
        category: NotificationCategory.workout,
        isRead: true,
      ),
      NotificationModel(
        id: 'notif_07',
        title: 'Weekly Wellness Summary Ready 📊',
        message:
            'You completed 4 workouts and 145 active minutes this week. Tap to view your insights.',
        timestamp: now.subtract(const Duration(days: 2)),
        category: NotificationCategory.goal,
        isRead: true,
      ),
      NotificationModel(
        id: 'notif_08',
        title: 'Sleep Optimization Tip 🌙',
        message:
            'Try cutting blue light 30 minutes before bed to enhance natural melatonin release.',
        timestamp: now.subtract(const Duration(days: 3)),
        category: NotificationCategory.wellness,
        isRead: true,
      ),
    ];
  }
}

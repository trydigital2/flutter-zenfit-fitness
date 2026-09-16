import 'package:get/get.dart';
import '../../../data/models/notification_model.dart';
import '../../../data/repositories/activity_repository.dart';
import '../../home/controllers/home_controller.dart';

class NotificationsController extends GetxController {
  final ActivityRepository _activityRepo = Get.find<ActivityRepository>();

  final notifications = <NotificationModel>[].obs;
  final filterUnreadOnly = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void loadNotifications() {
    notifications.value = _activityRepo.getNotifications();
  }

  List<NotificationModel> get displayedNotifications {
    if (filterUnreadOnly.value) {
      return notifications.where((n) => !n.isRead).toList();
    }
    return notifications;
  }

  Future<void> markAsRead(String id) async {
    await _activityRepo.markNotificationAsRead(id);
    loadNotifications();
    _refreshHomeBadge();
  }

  Future<void> markAllAsRead() async {
    await _activityRepo.markAllNotificationsAsRead();
    loadNotifications();
    _refreshHomeBadge();
  }

  Future<void> clearAll() async {
    await _activityRepo.clearAllNotifications();
    loadNotifications();
    _refreshHomeBadge();
  }

  void _refreshHomeBadge() {
    if (Get.isRegistered<HomeController>()) {
      Get.find<HomeController>().refreshMetrics();
    }
  }
}

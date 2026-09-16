import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/notifications_controller.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../core/widgets/custom_card.dart';
import '../../../core/widgets/empty_state_view.dart';
import '../../../data/models/notification_model.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationsController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      appBar: AppBar(
        title: const Text('Notification Center'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all_rounded),
            tooltip: 'Mark all as read',
            onPressed: controller.markAllAsRead,
          ),
          IconButton(
            icon: const Icon(Icons.delete_sweep_rounded),
            tooltip: 'Clear notifications',
            onPressed: controller.clearAll,
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: [
                Obx(
                  () => FilterChip(
                    label: const Text('All'),
                    selected: !controller.filterUnreadOnly.value,
                    onSelected: (val) =>
                        controller.filterUnreadOnly.value = false,
                    selectedColor: isDark
                        ? AppColors.accent
                        : AppColors.primary,
                    labelStyle: TextStyle(
                      color: !controller.filterUnreadOnly.value
                          ? (isDark ? AppColors.primaryDark : Colors.white)
                          : (isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.lightTextPrimary),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Obx(
                  () => FilterChip(
                    label: const Text('Unread Only'),
                    selected: controller.filterUnreadOnly.value,
                    onSelected: (val) =>
                        controller.filterUnreadOnly.value = true,
                    selectedColor: isDark
                        ? AppColors.accent
                        : AppColors.primary,
                    labelStyle: TextStyle(
                      color: controller.filterUnreadOnly.value
                          ? (isDark ? AppColors.primaryDark : Colors.white)
                          : (isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.lightTextPrimary),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Obx(() {
              final list = controller.displayedNotifications;

              if (list.isEmpty) {
                return const EmptyStateView(
                  icon: Icons.notifications_none_rounded,
                  title: 'All Caught Up!',
                  description:
                      'No new notifications right now. Keep moving and stay hydrated!',
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
                itemCount: list.length,
                separatorBuilder: (ctx, i) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final notif = list[index];
                  return CustomCard(
                    padding: const EdgeInsets.all(14),
                    color: notif.isRead
                        ? null
                        : (isDark
                              ? const Color(0xFF1B2A22)
                              : const Color(0xFFF0FDF4)),
                    border: Border.all(
                      color: notif.isRead
                          ? (isDark
                                ? AppColors.darkBorder
                                : AppColors.lightBorder)
                          : AppColors.accent.withAlpha(120),
                    ),
                    onTap: () {
                      if (!notif.isRead) {
                        controller.markAsRead(notif.id);
                      }
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: _getCategoryColor(
                              notif.category,
                            ).withAlpha(isDark ? 40 : 25),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _getCategoryIcon(notif.category),
                            color: _getCategoryColor(notif.category),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      notif.title,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: notif.isRead
                                            ? FontWeight.w600
                                            : FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    DateFormatter.timeAgo(notif.timestamp),
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: isDark
                                          ? AppColors.darkTextMuted
                                          : AppColors.lightTextMuted,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                notif.message,
                                style: TextStyle(
                                  fontSize: 13,
                                  height: 1.4,
                                  color: isDark
                                      ? AppColors.darkTextSecondary
                                      : AppColors.lightTextSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(NotificationCategory cat) {
    switch (cat) {
      case NotificationCategory.workout:
        return AppColors.accent;
      case NotificationCategory.hydration:
        return AppColors.waterBlue;
      case NotificationCategory.goal:
        return AppColors.streakGold;
      case NotificationCategory.wellness:
        return AppColors.mindfulPurple;
    }
  }

  IconData _getCategoryIcon(NotificationCategory cat) {
    switch (cat) {
      case NotificationCategory.workout:
        return Icons.fitness_center_rounded;
      case NotificationCategory.hydration:
        return Icons.water_drop_rounded;
      case NotificationCategory.goal:
        return Icons.emoji_events_rounded;
      case NotificationCategory.wellness:
        return Icons.spa_rounded;
    }
  }
}

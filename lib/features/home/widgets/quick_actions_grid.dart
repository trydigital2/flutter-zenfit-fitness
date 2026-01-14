import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_colors.dart';
import '../../navigation/controllers/navigation_controller.dart';
import '../controllers/home_controller.dart';

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final navCtrl = Get.find<NavigationController>();
    final homeCtrl = Get.find<HomeController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final actions = [
      {
        'label': 'Workouts',
        'icon': Icons.fitness_center_rounded,
        'color': AppColors.accent,
        'action': () => navCtrl.changePage(1),
      },
      {
        'label': 'Log Meal',
        'icon': Icons.restaurant_rounded,
        'color': AppColors.caloriesOrange,
        'action': () => navCtrl.changePage(2),
      },
      {
        'label': 'Add Water',
        'icon': Icons.water_drop_rounded,
        'color': AppColors.waterBlue,
        'action': () => homeCtrl.addWaterQuick(),
      },
      {
        'label': 'Breathe',
        'icon': Icons.air_rounded,
        'color': AppColors.mindfulPurple,
        'action': () => Get.toNamed(AppRoutes.breathing),
      },
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: actions.map((item) {
        final color = item['color'] as Color;
        final icon = item['icon'] as IconData;
        final label = item['label'] as String;
        final action = item['action'] as VoidCallback;

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: InkWell(
              onTap: action,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : AppColors.lightCard,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDark
                        ? AppColors.darkBorder
                        : AppColors.lightBorder,
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: color.withAlpha(isDark ? 40 : 25),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, color: color, size: 20),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.lightTextPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

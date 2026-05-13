import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/progress_controller.dart';
import '../../home/widgets/weekly_activity_chart.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../core/widgets/custom_card.dart';
import '../../../core/widgets/metric_badge.dart';
import '../../../core/widgets/section_header.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProgressController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      appBar: AppBar(
        title: const Text('Progress & History'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Streak Hero Card
            CustomCard(
              gradient: AppColors.primaryGradient,
              border: Border.all(color: AppColors.accent.withAlpha(60)),
              padding: const EdgeInsets.all(22),
              child: Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.streakGold.withAlpha(40),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.streakGold.withAlpha(100),
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.local_fire_department_rounded,
                      color: AppColors.streakGold,
                      size: 36,
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Text(
                            '${controller.currentStreak}-Day Workout Streak! 🔥',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'You are on fire this week. Maintain momentum to reach your 14-day badge.',
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.4,
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Lifetime Stats 4-Grid
            Obx(
              () => Row(
                children: [
                  Expanded(
                    child: _buildMetricTile(
                      icon: Icons.fitness_center_rounded,
                      color: AppColors.accent,
                      value: '${controller.totalWorkouts}',
                      label: 'Workouts Completed',
                      isDark: isDark,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildMetricTile(
                      icon: Icons.timer_outlined,
                      color: Colors.amber,
                      value:
                          '${(controller.totalMinutes / 60).toStringAsFixed(1)} h',
                      label: 'Total Training Time',
                      isDark: isDark,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Obx(
              () => Row(
                children: [
                  Expanded(
                    child: _buildMetricTile(
                      icon: Icons.local_fire_department_rounded,
                      color: AppColors.caloriesOrange,
                      value: '${controller.totalCalories}',
                      label: 'Total Calories Burned',
                      isDark: isDark,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildMetricTile(
                      icon: Icons.military_tech_rounded,
                      color: AppColors.mindfulPurple,
                      value: '94%',
                      label: 'Consistency Rate',
                      isDark: isDark,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Personal Records Section
            SectionHeader(
              title: 'Personal Records 🏆',
              subtitle: 'Your all-time fitness benchmarks',
              padding: EdgeInsets.zero,
            ),
            const SizedBox(height: 12),
            Obx(() {
              final longest = controller.longestWorkoutMinutes;
              final maxCal = controller.mostCaloriesBurned;
              return Row(
                children: [
                  Expanded(
                    child: CustomCard(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Longest Session',
                            style: TextStyle(fontSize: 12),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$longest min',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomCard(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Max Calorie Burn',
                            style: TextStyle(fontSize: 12),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$maxCal kcal',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.caloriesOrange,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),

            const SizedBox(height: 24),

            // Weekly Chart
            Obx(
              () => WeeklyActivityChart(
                weeklyData: controller.weeklyActivity.toList(),
              ),
            ),

            const SizedBox(height: 24),

            // Workout History List
            SectionHeader(
              title: 'Workout History',
              subtitle: 'Recent training sessions logged',
              padding: EdgeInsets.zero,
            ),
            const SizedBox(height: 12),
            Obx(
              () => ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.historyList.length,
                separatorBuilder: (ctx, i) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final item = controller.historyList[index];
                  return CustomCard(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.darkSurface
                                : AppColors.primaryContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            _getCategoryIcon(item.category),
                            color: isDark
                                ? AppColors.accent
                                : AppColors.primary,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.workoutTitle,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                DateFormatter.formatMonthDay(item.completedAt),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDark
                                      ? AppColors.darkTextSecondary
                                      : AppColors.lightTextSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            MetricBadge(
                              icon: Icons.timer_outlined,
                              label: '${item.durationMinutes} min',
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${item.caloriesBurned} kcal',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppColors.caloriesOrange,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // Scientific & Simulated disclaimer
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkCard
                    : AppColors.primaryContainer.withAlpha(60),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.info_outline_rounded,
                    size: 16,
                    color: AppColors.waterBlue,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Note: Workout duration and calorie burn values are simulated estimates based on standard metabolic equivalent (MET) tables for demo purposes.',
                      style: TextStyle(
                        fontSize: 11,
                        color: isDark
                            ? AppColors.darkTextMuted
                            : AppColors.lightTextMuted,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricTile({
    required IconData icon,
    required Color color,
    required String value,
    required String label,
    required bool isDark,
  }) {
    return CustomCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String cat) {
    switch (cat.toLowerCase()) {
      case 'hiit':
        return Icons.bolt_rounded;
      case 'strength':
        return Icons.fitness_center_rounded;
      case 'yoga':
        return Icons.self_improvement_rounded;
      case 'cardio':
        return Icons.directions_run_rounded;
      case 'core':
        return Icons.shield_rounded;
      default:
        return Icons.accessibility_new_rounded;
    }
  }
}

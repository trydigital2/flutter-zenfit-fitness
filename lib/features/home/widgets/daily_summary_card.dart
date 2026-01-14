import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/custom_card.dart';
import '../../../core/widgets/progress_ring.dart';
import '../../../data/models/activity_summary_model.dart';

class DailySummaryCard extends StatelessWidget {
  final ActivitySummaryModel activity;
  final VoidCallback? onTap;

  const DailySummaryCard({super.key, required this.activity, this.onTap});

  @override
  Widget build(BuildContext context) {
    final score = activity.overallDailyScore.toInt();

    return CustomCard(
      onTap: onTap,
      gradient: AppColors.heroCardGradient,
      border: Border.all(color: AppColors.accent.withAlpha(50), width: 1.2),
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accent.withAlpha(40),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'TODAY’S SCORE',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                            color: AppColors.accent,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Daily Goals On Track',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Keep pushing to close your rings!',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withAlpha(180),
                    ),
                  ),
                ],
              ),
              ProgressRing(
                progress: activity.overallDailyScore / 100,
                size: 76,
                strokeWidth: 8,
                primaryColor: AppColors.accent,
                backgroundColor: Colors.white.withAlpha(30),
                centerChild: Text(
                  '$score%',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(50),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMetricCol(
                  icon: Icons.directions_walk_rounded,
                  iconColor: AppColors.accent,
                  value: '${activity.steps}',
                  target: '/ ${activity.targetSteps}',
                  label: 'Steps',
                ),
                _buildDivider(),
                _buildMetricCol(
                  icon: Icons.local_fire_department_rounded,
                  iconColor: AppColors.caloriesOrange,
                  value: '${activity.calories}',
                  target: 'kcal',
                  label: 'Calories',
                ),
                _buildDivider(),
                _buildMetricCol(
                  icon: Icons.timer_rounded,
                  iconColor: Colors.amber,
                  value: '${activity.activeMinutes}',
                  target: 'min',
                  label: 'Active',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCol({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String target,
    required String label,
  }) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: iconColor),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: Colors.white.withAlpha(180),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 3),
            Text(
              target,
              style: TextStyle(
                fontSize: 11,
                color: Colors.white.withAlpha(150),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(width: 1, height: 28, color: Colors.white.withAlpha(30));
  }
}

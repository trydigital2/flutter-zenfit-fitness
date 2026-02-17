import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/app_network_image.dart';
import '../../../core/widgets/custom_card.dart';
import '../../../core/widgets/metric_badge.dart';
import '../../../data/models/workout_model.dart';
import '../controllers/workout_controller.dart';

class WorkoutCard extends StatelessWidget {
  final WorkoutModel workout;
  final VoidCallback onTap;
  final bool isCompact;

  const WorkoutCard({
    super.key,
    required this.workout,
    required this.onTap,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final workoutCtrl = Get.find<WorkoutController>();

    return CustomCard(
      onTap: onTap,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with Badges
          Stack(
            children: [
              AppNetworkImage(
                imageUrl: workout.imageUrl,
                height: isCompact ? 130 : 160,
                width: double.infinity,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              // Gradient Overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withAlpha(120),
                        Colors.transparent,
                        Colors.black.withAlpha(160),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              // Category Badge Top Left
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryDark.withAlpha(200),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.accent.withAlpha(80),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    workout.category.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                      color: AppColors.accent,
                    ),
                  ),
                ),
              ),
              // Favorite Button Top Right
              Positioned(
                top: 8,
                right: 8,
                child: Obx(() {
                  final isFav = workoutCtrl.isFavorite(workout.id);
                  return Material(
                    color: Colors.black.withAlpha(100),
                    shape: const CircleBorder(),
                    child: IconButton(
                      icon: Icon(
                        isFav
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: isFav ? AppColors.heartRed : Colors.white,
                        size: 20,
                      ),
                      onPressed: () => workoutCtrl.toggleFavorite(workout.id),
                    ),
                  );
                }),
              ),
              // Rating / Exercises Count Bottom Left
              Positioned(
                bottom: 10,
                left: 12,
                child: Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: AppColors.streakGold,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      workout.rating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${workout.exercises.length} exercises',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Content Area
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  workout.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: isCompact ? 15 : 17,
                    fontWeight: FontWeight.w700,
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.lightTextPrimary,
                  ),
                ),
                if (!isCompact) ...[
                  const SizedBox(height: 6),
                  Text(
                    workout.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.4,
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                Row(
                  children: [
                    MetricBadge(
                      icon: Icons.timer_outlined,
                      label: '${workout.durationMinutes} min',
                    ),
                    const SizedBox(width: 8),
                    MetricBadge(
                      icon: Icons.local_fire_department_outlined,
                      label: '${workout.caloriesBurned} kcal',
                      color: AppColors.caloriesOrange.withAlpha(
                        isDark ? 40 : 25,
                      ),
                      textColor: AppColors.caloriesOrange,
                    ),
                    const SizedBox(width: 8),
                    MetricBadge(
                      icon: Icons.speed_rounded,
                      label: workout.difficulty.displayName,
                      color: _getDifficultyColor(
                        workout.difficulty,
                      ).withAlpha(isDark ? 40 : 25),
                      textColor: _getDifficultyColor(workout.difficulty),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getDifficultyColor(WorkoutDifficulty diff) {
    switch (diff) {
      case WorkoutDifficulty.beginner:
        return AppColors.success;
      case WorkoutDifficulty.intermediate:
        return Colors.amber;
      case WorkoutDifficulty.advanced:
        return AppColors.caloriesOrange;
    }
  }
}

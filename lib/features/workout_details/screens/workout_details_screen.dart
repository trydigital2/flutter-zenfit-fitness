import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/workout_details_controller.dart';
import '../widgets/exercise_list_item.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/app_network_image.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/metric_badge.dart';
import '../../../core/widgets/section_header.dart';

class WorkoutDetailsScreen extends StatelessWidget {
  const WorkoutDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WorkoutDetailsController());
    final workout = controller.workout;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      body: Stack(
        children: [
          // Scrollable Content
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Image with Overlays
                Stack(
                  children: [
                    AppNetworkImage(
                      imageUrl: workout.imageUrl,
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withAlpha(140),
                              Colors.transparent,
                              (isDark ? AppColors.darkBg : AppColors.lightBg)
                                  .withAlpha(240),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                    // App Bar Actions
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.black.withAlpha(120),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_rounded,
                                  color: Colors.white,
                                ),
                                onPressed: () => Get.back(),
                              ),
                            ),
                            Obx(
                              () => CircleAvatar(
                                backgroundColor: Colors.black.withAlpha(120),
                                child: IconButton(
                                  icon: Icon(
                                    controller.isFavorite.value
                                        ? Icons.favorite_rounded
                                        : Icons.favorite_border_rounded,
                                    color: controller.isFavorite.value
                                        ? AppColors.heartRed
                                        : Colors.white,
                                  ),
                                  onPressed: controller.toggleFavorite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // Main Info
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category & Rating
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.accent.withAlpha(40),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              workout.category.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.5,
                                color: AppColors.accent,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: AppColors.streakGold,
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${workout.rating} (1.2k reviews)',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: isDark
                                      ? AppColors.darkTextSecondary
                                      : AppColors.lightTextSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Title
                      Text(
                        workout.title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                          color: isDark
                              ? AppColors.darkTextPrimary
                              : AppColors.lightTextPrimary,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Metric Badges
                      Row(
                        children: [
                          MetricBadge(
                            icon: Icons.timer_outlined,
                            label: '${workout.durationMinutes} min',
                            fontSize: 13,
                            iconSize: 16,
                          ),
                          const SizedBox(width: 10),
                          MetricBadge(
                            icon: Icons.local_fire_department_outlined,
                            label: '${workout.caloriesBurned} kcal',
                            color: AppColors.caloriesOrange.withAlpha(
                              isDark ? 40 : 25,
                            ),
                            textColor: AppColors.caloriesOrange,
                            fontSize: 13,
                            iconSize: 16,
                          ),
                          const SizedBox(width: 10),
                          MetricBadge(
                            icon: Icons.speed_rounded,
                            label: workout.difficulty.displayName,
                            color: AppColors.accent.withAlpha(isDark ? 40 : 25),
                            textColor: isDark
                                ? AppColors.accent
                                : AppColors.primary,
                            fontSize: 13,
                            iconSize: 16,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Description
                      Text(
                        'About This Routine',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? AppColors.darkTextPrimary
                              : AppColors.lightTextPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        workout.description,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Equipment Needed
                      Text(
                        'Required Equipment',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? AppColors.darkTextPrimary
                              : AppColors.lightTextPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: workout.equipment
                            .map(
                              (eq) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? AppColors.darkCard
                                      : AppColors.lightCard,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: isDark
                                        ? AppColors.darkBorder
                                        : AppColors.lightBorder,
                                  ),
                                ),
                                child: Text(
                                  eq,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: isDark
                                        ? AppColors.darkTextPrimary
                                        : AppColors.lightTextPrimary,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 20),

                      // Target Muscles
                      Text(
                        'Targeted Muscle Groups',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? AppColors.darkTextPrimary
                              : AppColors.lightTextPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: workout.targetMuscles
                            .map(
                              (m) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? AppColors.accent.withAlpha(30)
                                      : AppColors.primaryContainer,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  m,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: isDark
                                        ? AppColors.accent
                                        : AppColors.primary,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Exercise Breakdown
                SectionHeader(
                  title: 'Exercises (${workout.exercises.length})',
                  subtitle: 'Step-by-step workout sequence',
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: workout.exercises.length,
                  separatorBuilder: (ctx, i) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final ex = workout.exercises[index];
                    return ExerciseListItem(index: index, exercise: ex);
                  },
                ),
              ],
            ),
          ),

          // Sticky Bottom "Start Workout" Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkSurface.withAlpha(240)
                    : Colors.white.withAlpha(240),
                border: Border(
                  top: BorderSide(
                    color: isDark
                        ? AppColors.darkBorder
                        : AppColors.lightBorder,
                  ),
                ),
              ),
              child: CustomButton(
                text: 'Start Workout Session',
                icon: Icons.play_arrow_rounded,
                variant: ButtonVariant.accent,
                onPressed: () =>
                    Get.toNamed(AppRoutes.activeWorkout, arguments: workout),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

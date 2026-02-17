import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/workout_controller.dart';
import '../widgets/workout_card.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/empty_state_view.dart';
import '../../../data/models/workout_model.dart';

class WorkoutLibraryScreen extends StatelessWidget {
  const WorkoutLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WorkoutController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Workout Library',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                          color: isDark
                              ? AppColors.darkTextPrimary
                              : AppColors.lightTextPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Discover guided training for every goal',
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.favorite_rounded,
                      color: AppColors.heartRed,
                    ),
                    onPressed: () => Get.toNamed(AppRoutes.favorites),
                    tooltip: 'Saved Workouts',
                  ),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                onChanged: controller.onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'Search workouts, muscles, equipment...',
                  prefixIcon: const Icon(Icons.search_rounded, size: 22),
                  suffixIcon: Obx(
                    () => controller.searchQuery.value.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear_rounded, size: 18),
                            onPressed: () => controller.onSearchChanged(''),
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Category Filter Pills
            SizedBox(
              height: 38,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                itemCount: controller.categories.length,
                separatorBuilder: (ctx, i) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final cat = controller.categories[index];
                  return Obx(() {
                    final isSelected = controller.selectedCategory.value == cat;
                    return InkWell(
                      onTap: () => controller.onCategorySelected(cat),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? (isDark ? AppColors.accent : AppColors.primary)
                              : (isDark
                                    ? AppColors.darkCard
                                    : AppColors.lightCard),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? Colors.transparent
                                : (isDark
                                      ? AppColors.darkBorder
                                      : AppColors.lightBorder),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            cat,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: isSelected
                                  ? (isDark
                                        ? AppColors.primaryDark
                                        : Colors.white)
                                  : (isDark
                                        ? AppColors.darkTextPrimary
                                        : AppColors.lightTextPrimary),
                            ),
                          ),
                        ),
                      ),
                    );
                  });
                },
              ),
            ),

            const SizedBox(height: 10),

            // Difficulty Filters
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    'Level:',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppColors.darkTextMuted
                          : AppColors.lightTextMuted,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildDifficultyChip(
                    label: 'All',
                    isSelected: controller.selectedDifficulty.value == null,
                    onTap: () => controller.onDifficultySelected(null),
                    isDark: isDark,
                  ),
                  const SizedBox(width: 6),
                  _buildDifficultyChip(
                    label: 'Beginner',
                    isSelected:
                        controller.selectedDifficulty.value ==
                        WorkoutDifficulty.beginner,
                    onTap: () => controller.onDifficultySelected(
                      WorkoutDifficulty.beginner,
                    ),
                    isDark: isDark,
                  ),
                  const SizedBox(width: 6),
                  _buildDifficultyChip(
                    label: 'Intermediate',
                    isSelected:
                        controller.selectedDifficulty.value ==
                        WorkoutDifficulty.intermediate,
                    onTap: () => controller.onDifficultySelected(
                      WorkoutDifficulty.intermediate,
                    ),
                    isDark: isDark,
                  ),
                  const SizedBox(width: 6),
                  _buildDifficultyChip(
                    label: 'Advanced',
                    isSelected:
                        controller.selectedDifficulty.value ==
                        WorkoutDifficulty.advanced,
                    onTap: () => controller.onDifficultySelected(
                      WorkoutDifficulty.advanced,
                    ),
                    isDark: isDark,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Workouts List
            Expanded(
              child: Obx(() {
                final list = controller.filteredWorkouts;

                if (list.isEmpty) {
                  return EmptyStateView(
                    icon: Icons.fitness_center_rounded,
                    title: 'No Workouts Found',
                    description:
                        'No routines match your current filters. Try resetting the search or category filter.',
                    buttonText: 'Reset Filters',
                    onButtonPressed: controller.clearFilters,
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 6, 20, 100),
                  itemCount: list.length,
                  separatorBuilder: (ctx, i) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final workout = list[index];
                    return WorkoutCard(
                      workout: workout,
                      onTap: () => Get.toNamed(
                        AppRoutes.workoutDetails,
                        arguments: workout,
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDifficultyChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark
                    ? AppColors.accent.withAlpha(50)
                    : AppColors.primaryContainer)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? (isDark ? AppColors.accent : AppColors.primary)
                : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected
                ? (isDark ? AppColors.accent : AppColors.primary)
                : (isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary),
          ),
        ),
      ),
    );
  }
}

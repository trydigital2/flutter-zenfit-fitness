import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/search_controller.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/app_network_image.dart';
import '../../../core/widgets/custom_card.dart';
import '../../../core/widgets/empty_state_view.dart';

class GlobalSearchScreen extends StatelessWidget {
  const GlobalSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GlobalSearchController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          onChanged: controller.onQueryChanged,
          decoration: const InputDecoration(
            hintText: 'Search workouts, foods, wellness...',
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            filled: false,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          // Filter Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Obx(
                () => Row(
                  children: SearchTab.values.map((tab) {
                    final isSelected = controller.currentTab.value == tab;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(tab.name.capitalizeFirst!),
                        selected: isSelected,
                        onSelected: (val) => controller.onTabChanged(tab),
                        selectedColor: isDark
                            ? AppColors.accent
                            : AppColors.primary,
                        labelStyle: TextStyle(
                          color: isSelected
                              ? (isDark ? AppColors.primaryDark : Colors.white)
                              : (isDark
                                    ? AppColors.darkTextPrimary
                                    : AppColors.lightTextPrimary),
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),

          // Results
          Expanded(
            child: Obx(() {
              if (controller.searchQuery.value.trim().isEmpty) {
                return const EmptyStateView(
                  icon: Icons.search_rounded,
                  title: 'Search ZenFit',
                  description:
                      'Find routines like HIIT, breakfast bowls, or sleep relaxation sessions.',
                );
              }

              if (controller.totalResultsCount == 0) {
                return EmptyStateView(
                  icon: Icons.search_off_rounded,
                  title: 'No Matches Found',
                  description:
                      'We couldn’t find anything matching "${controller.searchQuery.value}". Try a different keyword.',
                );
              }

              return ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
                children: [
                  // Workouts Section
                  if (controller.currentTab.value == SearchTab.all ||
                      controller.currentTab.value == SearchTab.workouts) ...[
                    if (controller.matchingWorkouts.isNotEmpty) ...[
                      _buildHeader(
                        'Workouts (${controller.matchingWorkouts.length})',
                        isDark,
                      ),
                      ...controller.matchingWorkouts.map(
                        (w) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: CustomCard(
                            padding: const EdgeInsets.all(12),
                            onTap: () => Get.toNamed(
                              AppRoutes.workoutDetails,
                              arguments: w,
                            ),
                            child: Row(
                              children: [
                                AppNetworkImage(
                                  imageUrl: w.imageUrl,
                                  width: 56,
                                  height: 56,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        w.title,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        '${w.category} • ${w.durationMinutes}m • ${w.caloriesBurned} kcal',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: isDark
                                              ? AppColors.darkTextSecondary
                                              : AppColors.lightTextSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.chevron_right_rounded),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ],

                  // Foods Section
                  if (controller.currentTab.value == SearchTab.all ||
                      controller.currentTab.value == SearchTab.foods) ...[
                    if (controller.matchingFoods.isNotEmpty) ...[
                      _buildHeader(
                        'Foods & Nutrition (${controller.matchingFoods.length})',
                        isDark,
                      ),
                      ...controller.matchingFoods.map(
                        (f) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: CustomCard(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                AppNetworkImage(
                                  imageUrl: f.imageUrl,
                                  width: 56,
                                  height: 56,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        f.name,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        '${f.servingSize} • ${f.calories} kcal • P: ${f.proteinGrams}g',
                                        style: TextStyle(
                                          fontSize: 11,
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
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ],

                  // Wellness Section
                  if (controller.currentTab.value == SearchTab.all ||
                      controller.currentTab.value == SearchTab.wellness) ...[
                    if (controller.matchingWellness.isNotEmpty) ...[
                      _buildHeader(
                        'Mindfulness & Wellness (${controller.matchingWellness.length})',
                        isDark,
                      ),
                      ...controller.matchingWellness.map(
                        (s) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: CustomCard(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                AppNetworkImage(
                                  imageUrl: s.imageUrl,
                                  width: 56,
                                  height: 56,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        s.title,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        '${s.category} • ${s.instructor} • ${s.durationMinutes}m',
                                        style: TextStyle(
                                          fontSize: 11,
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
                          ),
                        ),
                      ),
                    ],
                  ],
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(String title, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w800,
          color: isDark
              ? AppColors.darkTextPrimary
              : AppColors.lightTextPrimary,
        ),
      ),
    );
  }
}

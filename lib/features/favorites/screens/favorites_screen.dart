import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/favorites_controller.dart';
import '../../workouts/widgets/workout_card.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/app_network_image.dart';
import '../../../core/widgets/custom_card.dart';
import '../../../core/widgets/empty_state_view.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoritesController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      appBar: AppBar(
        title: const Text('Saved Favorites'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          // Segmented Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : AppColors.primaryContainer,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Obx(
                () => Row(
                  children: [
                    Expanded(
                      child: _buildTabButton(
                        label:
                            'Workouts (${controller.favoriteWorkouts.length})',
                        isSelected: controller.selectedTab.value == 0,
                        onTap: () => controller.selectedTab.value = 0,
                        isDark: isDark,
                      ),
                    ),
                    Expanded(
                      child: _buildTabButton(
                        label:
                            'Mindfulness (${controller.favoriteMeditations.length})',
                        isSelected: controller.selectedTab.value == 1,
                        onTap: () => controller.selectedTab.value = 1,
                        isDark: isDark,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Content
          Expanded(
            child: Obx(() {
              if (controller.selectedTab.value == 0) {
                // Workouts
                final list = controller.favoriteWorkouts;
                if (list.isEmpty) {
                  return EmptyStateView(
                    icon: Icons.favorite_border_rounded,
                    title: 'No Saved Workouts',
                    description:
                        'Tap the heart icon on any routine in the workout library to save it here for quick access.',
                    buttonText: 'Browse Workouts',
                    onButtonPressed: () => Get.back(),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                  itemCount: list.length,
                  separatorBuilder: (ctx, i) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final item = list[index];
                    return WorkoutCard(
                      workout: item,
                      onTap: () => Get.toNamed(
                        AppRoutes.workoutDetails,
                        arguments: item,
                      ),
                    );
                  },
                );
              } else {
                // Meditations
                final list = controller.favoriteMeditations;
                if (list.isEmpty) {
                  return EmptyStateView(
                    icon: Icons.spa_outlined,
                    title: 'No Saved Sessions',
                    description:
                        'Bookmark mindfulness, breathing, or sleep sessions from the Wellness screen.',
                    buttonText: 'Explore Wellness',
                    onButtonPressed: () => Get.back(),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                  itemCount: list.length,
                  separatorBuilder: (ctx, i) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final item = list[index];
                    return CustomCard(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          AppNetworkImage(
                            imageUrl: item.imageUrl,
                            width: 60,
                            height: 60,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${item.instructor} • ${item.durationMinutes} min',
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
                          IconButton(
                            icon: const Icon(
                              Icons.favorite_rounded,
                              color: AppColors.heartRed,
                            ),
                            onPressed: () =>
                                controller.removeMeditationFavorite(item.id),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? AppColors.darkSurface : Colors.white)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isSelected && !isDark
              ? [BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 4)]
              : [],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected
                  ? (isDark ? AppColors.accent : AppColors.primary)
                  : (isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary),
            ),
          ),
        ),
      ),
    );
  }
}

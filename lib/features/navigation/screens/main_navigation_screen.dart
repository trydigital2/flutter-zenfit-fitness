import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/navigation_controller.dart';
import '../../home/screens/home_screen.dart';
import '../../workouts/screens/workout_library_screen.dart';
import '../../nutrition/screens/nutrition_screen.dart';
import '../../wellness/screens/wellness_screen.dart';
import '../../profile/screens/profile_screen.dart';
import '../../../app/theme/app_colors.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NavigationController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final pages = const [
      HomeScreen(),
      WorkoutLibraryScreen(),
      NutritionScreen(),
      WellnessScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      body: Obx(
        () => IndexedStack(index: controller.currentIndex, children: pages),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : Colors.white,
          border: Border(
            top: BorderSide(
              color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              width: 1,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(isDark ? 30 : 8),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    icon: Icons.home_rounded,
                    outlineIcon: Icons.home_outlined,
                    label: 'Home',
                    isSelected: controller.currentIndex == 0,
                    onTap: () => controller.changePage(0),
                    isDark: isDark,
                  ),
                  _buildNavItem(
                    icon: Icons.fitness_center_rounded,
                    outlineIcon: Icons.fitness_center_outlined,
                    label: 'Workouts',
                    isSelected: controller.currentIndex == 1,
                    onTap: () => controller.changePage(1),
                    isDark: isDark,
                  ),
                  _buildNavItem(
                    icon: Icons.restaurant_rounded,
                    outlineIcon: Icons.restaurant_outlined,
                    label: 'Nutrition',
                    isSelected: controller.currentIndex == 2,
                    onTap: () => controller.changePage(2),
                    isDark: isDark,
                  ),
                  _buildNavItem(
                    icon: Icons.spa_rounded,
                    outlineIcon: Icons.spa_outlined,
                    label: 'Wellness',
                    isSelected: controller.currentIndex == 3,
                    onTap: () => controller.changePage(3),
                    isDark: isDark,
                  ),
                  _buildNavItem(
                    icon: Icons.person_rounded,
                    outlineIcon: Icons.person_outline_rounded,
                    label: 'Profile',
                    isSelected: controller.currentIndex == 4,
                    onTap: () => controller.changePage(4),
                    isDark: isDark,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required IconData outlineIcon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    final activeColor = isDark ? AppColors.accent : AppColors.primary;
    final inactiveColor = isDark
        ? AppColors.darkTextMuted
        : AppColors.lightTextMuted;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              decoration: BoxDecoration(
                color: isSelected
                    ? activeColor.withAlpha(isDark ? 40 : 25)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                isSelected ? icon : outlineIcon,
                color: isSelected ? activeColor : inactiveColor,
                size: 22,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? activeColor : inactiveColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

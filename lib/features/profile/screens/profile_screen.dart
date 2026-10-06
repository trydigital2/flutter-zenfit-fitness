import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import 'edit_profile_dialog.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/app_network_image.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_card.dart';
import '../../../core/widgets/section_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Profile & Settings',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.lightTextPrimary,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      tooltip: 'Edit Profile',
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (ctx) => const EditProfileDialog(),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // Profile Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(() {
                  final p = controller.userProfile.value;
                  if (p == null) return const SizedBox.shrink();

                  return CustomCard(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.accent,
                                  width: 2.5,
                                ),
                              ),
                              child: const ClipOval(
                                child: AppNetworkImage(
                                  imageUrl:
                                      'assets/images/avatars/user_avatar.svg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    p.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    p.email,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isDark
                                          ? AppColors.darkTextSecondary
                                          : AppColors.lightTextSecondary,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.accent.withAlpha(
                                        isDark ? 40 : 25,
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      '${p.fitnessLevel} • ${p.fitnessGoal}',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: isDark
                                            ? AppColors.accent
                                            : AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 18),
                        const Divider(),
                        const SizedBox(height: 14),

                        // Physical Metrics Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildMetricCol('Weight', '${p.weightKg} kg'),
                            _buildDivider(),
                            _buildMetricCol(
                              'Height',
                              '${p.heightCm.toInt()} cm',
                            ),
                            _buildDivider(),
                            _buildMetricCol(
                              'BMI',
                              '${p.bmi.toStringAsFixed(1)} (${p.bmiCategory.split(' ').first})',
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ),

              const SizedBox(height: 20),

              // Quick Feature Nav Links
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildSettingsTile(
                      icon: Icons.track_changes_rounded,
                      color: AppColors.accent,
                      title: 'Goals & Habit Tracker',
                      subtitle: 'Customize daily step, water, & habit targets',
                      onTap: () => Get.toNamed(AppRoutes.goals),
                      isDark: isDark,
                    ),
                    const SizedBox(height: 8),
                    _buildSettingsTile(
                      icon: Icons.history_rounded,
                      color: Colors.amber,
                      title: 'Workout History & Stats',
                      subtitle:
                          'View lifetime training duration and calorie records',
                      onTap: () => Get.toNamed(AppRoutes.progress),
                      isDark: isDark,
                    ),
                    const SizedBox(height: 8),
                    _buildSettingsTile(
                      icon: Icons.favorite_rounded,
                      color: AppColors.heartRed,
                      title: 'Saved Favorites',
                      subtitle: 'Bookmarked routines and meditations',
                      onTap: () => Get.toNamed(AppRoutes.favorites),
                      isDark: isDark,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Preferences Section
              SectionHeader(
                title: 'Preferences',
                subtitle: 'Customize appearance and notifications',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomCard(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      // Dark Theme Toggle
                      Obx(
                        () => SwitchListTile(
                          title: const Text(
                            'Dark Mode',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            'Switch between forest light and slate dark aesthetics',
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.lightTextSecondary,
                            ),
                          ),
                          secondary: const Icon(Icons.dark_mode_rounded),
                          value: controller.isDarkMode.value,
                          activeThumbColor: AppColors.accent,
                          onChanged: (val) => controller.toggleTheme(val),
                        ),
                      ),
                      const Divider(),
                      // Workout Reminders
                      Obx(
                        () => SwitchListTile(
                          title: const Text(
                            'Daily Workout Reminders',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          secondary: const Icon(Icons.fitness_center_rounded),
                          value: controller.workoutRemindersEnabled.value,
                          activeThumbColor: AppColors.accent,
                          onChanged: (val) =>
                              controller.workoutRemindersEnabled.value = val,
                        ),
                      ),
                      const Divider(),
                      // Water Intake Reminders
                      Obx(
                        () => SwitchListTile(
                          title: const Text(
                            'Hydration Prompts',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          secondary: const Icon(Icons.water_drop_rounded),
                          value: controller.waterRemindersEnabled.value,
                          activeThumbColor: AppColors.accent,
                          onChanged: (val) =>
                              controller.waterRemindersEnabled.value = val,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // About & Legal
              SectionHeader(
                title: 'About ZenFit',
                subtitle: 'Application details and policies',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomCard(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.info_outline_rounded),
                        title: const Text('About Application'),
                        subtitle: Text(
                          'v${AppConstants.appVersion}+${AppConstants.buildNumber} • Built with Flutter & Material 3',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                          ),
                        ),
                        trailing: const Icon(Icons.chevron_right_rounded),
                        onTap: () => _showAboutAppDialog(context),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.privacy_tip_outlined),
                        title: const Text('Privacy Policy'),
                        trailing: const Icon(Icons.chevron_right_rounded),
                        onTap: () => _showLegalDialog(
                          context,
                          'Privacy Policy',
                          'ZenFit is built with a local-first philosophy. None of your health metrics, workout history, or profile details are sold, transmitted to third-party ad networks, or uploaded without your explicit consent. All data stays securely on your local device.',
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.description_outlined),
                        title: const Text('Terms of Service'),
                        trailing: const Icon(Icons.chevron_right_rounded),
                        onTap: () => _showLegalDialog(
                          context,
                          'Terms of Service',
                          'ZenFit provides guidance for wellness and physical activity. Consult a medical professional before starting any intensive fitness regimen. Simulated calorie and nutritional metrics are estimations for planning purposes.',
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Reset Demo Data Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                  text: 'Reset Demo Data to Initial State',
                  icon: Icons.restart_alt_rounded,
                  variant: ButtonVariant.outline,
                  width: double.infinity,
                  onPressed: () => _confirmReset(context, controller),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCol(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 11)),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(width: 1, height: 24, color: Colors.grey.withAlpha(50));
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return CustomCard(
      padding: const EdgeInsets.all(14),
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withAlpha(isDark ? 40 : 25),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  subtitle,
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
          const Icon(Icons.chevron_right_rounded, size: 20),
        ],
      ),
    );
  }

  void _confirmReset(BuildContext context, ProfileController controller) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reset Demo Data?'),
        content: const Text(
          'This will restore all default mock workouts, foods, habits, and user profile settings to the clean seed state.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              Navigator.pop(ctx);
              await controller.resetDemoData();
            },
            child: const Text('Reset All'),
          ),
        ],
      ),
    );
  }

  void _showAboutAppDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(6),
              child: const Icon(Icons.bolt_rounded, color: AppColors.accent),
            ),
            const SizedBox(width: 10),
            const Text('About ZenFit'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ZenFit — "Move Better. Feel Better. Live Better."',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8),
            Text(
              'A modern, production-grade Flutter & Material 3 wellness application featuring local mock datasets, GetX reactive architecture, SharedPreferences persistence, fl_chart visualizations, and box breathing timers.',
              style: TextStyle(fontSize: 13, height: 1.4),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showLegalDialog(BuildContext context, String title, String body) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(body, style: const TextStyle(fontSize: 13, height: 1.4)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

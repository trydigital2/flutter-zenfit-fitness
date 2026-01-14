import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../widgets/daily_summary_card.dart';
import '../widgets/metric_card.dart';
import '../widgets/water_tracker_widget.dart';
import '../widgets/quick_actions_grid.dart';
import '../widgets/weekly_activity_chart.dart';
import '../../workouts/widgets/workout_card.dart';
import '../../navigation/controllers/navigation_controller.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/custom_card.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/app_network_image.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final navCtrl = Get.find<NavigationController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            controller.loadDashboardData();
          },
          color: AppColors.accent,
          backgroundColor: isDark ? AppColors.darkCard : Colors.white,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top App Bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => navCtrl.changePage(4),
                              child: Container(
                                width: 46,
                                height: 46,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.accent,
                                    width: 2,
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
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(
                                    () => Text(
                                      controller.greeting,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: -0.3,
                                        color: isDark
                                            ? AppColors.darkTextPrimary
                                            : AppColors.lightTextPrimary,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Ready for your wellness journey today?',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
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
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => Get.toNamed(AppRoutes.search),
                            icon: Icon(
                              Icons.search_rounded,
                              color: isDark
                                  ? AppColors.darkTextPrimary
                                  : AppColors.lightTextPrimary,
                            ),
                          ),
                          Stack(
                            children: [
                              IconButton(
                                onPressed: () =>
                                    Get.toNamed(AppRoutes.notifications),
                                icon: Icon(
                                  Icons.notifications_outlined,
                                  color: isDark
                                      ? AppColors.darkTextPrimary
                                      : AppColors.lightTextPrimary,
                                ),
                              ),
                              Obx(
                                () =>
                                    controller.unreadNotificationsCount.value >
                                        0
                                    ? Positioned(
                                        right: 10,
                                        top: 10,
                                        child: Container(
                                          width: 9,
                                          height: 9,
                                          decoration: const BoxDecoration(
                                            color: AppColors.caloriesOrange,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // Motivational Quote Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Obx(() {
                    final q = controller
                        .motivationalQuotes[controller.currentQuoteIndex.value];
                    return CustomCard(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      color: isDark
                          ? AppColors.darkCard
                          : const Color(0xFFEFF5F1),
                      border: Border.all(
                        color: isDark
                            ? AppColors.darkBorder
                            : AppColors.primaryLight.withAlpha(40),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.format_quote_rounded,
                            color: isDark
                                ? AppColors.accent
                                : AppColors.primaryLight,
                            size: 26,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '"${q['quote']}"',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w500,
                                    color: isDark
                                        ? AppColors.darkTextPrimary
                                        : AppColors.lightTextPrimary,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '— ${q['author']}',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: isDark
                                        ? AppColors.darkTextMuted
                                        : AppColors.lightTextMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.refresh_rounded, size: 18),
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                            onPressed: () {
                              controller.currentQuoteIndex.value =
                                  (controller.currentQuoteIndex.value + 1) %
                                  controller.motivationalQuotes.length;
                            },
                          ),
                        ],
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 16),

                // Daily Summary Card (Hero Score)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Obx(() {
                    final act = controller.todayActivity.value;
                    if (act == null) return const SizedBox.shrink();
                    return DailySummaryCard(
                      activity: act,
                      onTap: () => Get.toNamed(AppRoutes.progress),
                    );
                  }),
                ),

                const SizedBox(height: 16),

                // Quick Action Shortcuts (Workouts, Log Meal, Add Water, Breathe)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: QuickActionsGrid(),
                ),

                const SizedBox(height: 16),

                // 2x2 Metric Cards: Steps & Calories
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Obx(() {
                    final act = controller.todayActivity.value;
                    if (act == null) return const SizedBox.shrink();

                    return Row(
                      children: [
                        Expanded(
                          child: MetricCard(
                            title: 'Steps Counter',
                            value: '${act.steps}',
                            unit: '/ ${act.targetSteps}',
                            progress: act.stepProgress,
                            icon: Icons.directions_walk_rounded,
                            accentColor: AppColors.accent,
                            onTap: () => Get.toNamed(AppRoutes.goals),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: MetricCard(
                            title: 'Calories Burned',
                            value: '${act.calories}',
                            unit: 'kcal',
                            progress: act.calorieProgress,
                            icon: Icons.local_fire_department_rounded,
                            accentColor: AppColors.caloriesOrange,
                            onTap: () => Get.toNamed(AppRoutes.progress),
                          ),
                        ),
                      ],
                    );
                  }),
                ),

                const SizedBox(height: 14),

                // Interactive Water Tracker
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Obx(() {
                    final act = controller.todayActivity.value;
                    if (act == null) return const SizedBox.shrink();

                    return WaterTrackerWidget(
                      currentLiters: act.waterLiters,
                      targetLiters: act.targetWaterLiters,
                      onAddWater: () => controller.addWaterQuick(),
                    );
                  }),
                ),

                const SizedBox(height: 20),

                // Today's Workout Feature Card
                SectionHeader(
                  title: 'Today’s Workout',
                  subtitle: 'Curated for your goals & energy level',
                  actionText: 'Explore All',
                  onActionTap: () => navCtrl.changePage(1),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Obx(() {
                    final workout = controller.todayWorkout.value;
                    if (workout == null) return const SizedBox.shrink();

                    return WorkoutCard(
                      workout: workout,
                      onTap: () => Get.toNamed(
                        AppRoutes.workoutDetails,
                        arguments: workout,
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 24),

                // Weekly Activity Chart
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Obx(
                    () => WeeklyActivityChart(
                      weeklyData: controller.weeklyActivity,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Recommended Workouts Horizontal List
                SectionHeader(
                  title: 'Recommended For You',
                  subtitle: 'Handpicked routines for balanced fitness',
                  actionText: 'See Library',
                  onActionTap: () => navCtrl.changePage(1),
                ),
                SizedBox(
                  height: 250,
                  child: Obx(() {
                    final list = controller.recommendedWorkouts;
                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      scrollDirection: Axis.horizontal,
                      itemCount: list.length,
                      separatorBuilder: (ctx, i) => const SizedBox(width: 14),
                      itemBuilder: (context, index) {
                        final item = list[index];
                        return SizedBox(
                          width: 280,
                          child: WorkoutCard(
                            workout: item,
                            isCompact: true,
                            onTap: () => Get.toNamed(
                              AppRoutes.workoutDetails,
                              arguments: item,
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),

                const SizedBox(height: 24),

                // Habits & Mindfulness Reminder Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomCard(
                    padding: const EdgeInsets.all(18),
                    color: isDark
                        ? AppColors.darkCard
                        : const Color(0xFFF3E8FF).withAlpha(150),
                    border: Border.all(
                      color: AppColors.mindfulPurple.withAlpha(60),
                    ),
                    onTap: () => Get.toNamed(AppRoutes.goals),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.mindfulPurple.withAlpha(40),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.check_circle_outline_rounded,
                            color: AppColors.mindfulPurple,
                            size: 26,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Daily Habits & Mindful Streaks',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: isDark
                                      ? AppColors.darkTextPrimary
                                      : AppColors.lightTextPrimary,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Track consistency across 6 daily wellness habits.',
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
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16,
                          color: AppColors.mindfulPurple,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

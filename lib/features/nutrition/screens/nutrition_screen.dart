import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/nutrition_controller.dart';
import 'add_meal_dialog.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/app_network_image.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_card.dart';
import '../../../core/widgets/progress_ring.dart';
import '../../../core/widgets/section_header.dart';
import '../../../data/models/meal_model.dart';

class NutritionScreen extends StatelessWidget {
  const NutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NutritionController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Header
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nutrition & Fuel',
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
                            'Track balanced macros and daily calories',
                            style: TextStyle(
                              fontSize: 13,
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.lightTextSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    CustomButton(
                      text: '+ Add Meal',
                      variant: ButtonVariant.accent,
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (ctx) => const AddMealDialog(),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // Daily Calorie Summary Hero Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(() {
                  final consumed = controller.caloriesConsumed;
                  final remaining = controller.caloriesRemaining;
                  final target = controller.dailyCalorieTarget;
                  final progress = controller.calorieProgress;

                  return CustomCard(
                    gradient: AppColors.heroCardGradient,
                    border: Border.all(
                      color: AppColors.accent.withAlpha(50),
                      width: 1.2,
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'CALORIE BUDGET',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.6,
                                    color: AppColors.accent,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      '$consumed',
                                      style: const TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      '/ $target kcal',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white.withAlpha(180),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '$remaining kcal remaining today',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white.withAlpha(160),
                                  ),
                                ),
                              ],
                            ),
                            ProgressRing(
                              progress: progress,
                              size: 78,
                              strokeWidth: 8,
                              primaryColor: AppColors.caloriesOrange,
                              backgroundColor: Colors.white.withAlpha(30),
                              centerChild: Text(
                                '${(progress * 100).toInt()}%',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Macro Bars (Protein, Carbs, Fat)
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(50),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              _buildMacroRow(
                                name: 'Protein',
                                current: controller.dailyTotals.totalProtein,
                                target: controller.dailyProteinTarget,
                                color: AppColors.accent,
                                progress: controller.proteinProgress,
                              ),
                              const SizedBox(height: 10),
                              _buildMacroRow(
                                name: 'Carbs',
                                current: controller.dailyTotals.totalCarbs,
                                target: controller.dailyCarbsTarget,
                                color: Colors.amber,
                                progress: controller.carbsProgress,
                              ),
                              const SizedBox(height: 10),
                              _buildMacroRow(
                                name: 'Fats',
                                current: controller.dailyTotals.totalFat,
                                target: controller.dailyFatTarget,
                                color: AppColors.mindfulPurple,
                                progress: controller.fatProgress,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),

              const SizedBox(height: 20),

              // Sample Meal Templates Carousel (Quick 1-Tap Logging)
              SectionHeader(
                title: 'Quick Meal Ideas',
                subtitle: 'Add wholesome dietitian-crafted meals in 1 tap',
              ),
              SizedBox(
                height: 140,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.getSampleTemplates().length,
                  separatorBuilder: (ctx, i) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final t = controller.getSampleTemplates()[index];
                    return SizedBox(
                      width: 240,
                      child: CustomCard(
                        padding: const EdgeInsets.all(12),
                        onTap: () {
                          controller.logSampleTemplate(t);
                          Get.snackbar(
                            'Added ${t.name}',
                            'Logged to ${t.mealType.displayName}!',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppColors.primary,
                            colorText: Colors.white,
                            duration: const Duration(seconds: 2),
                          );
                        },
                        child: Row(
                          children: [
                            AppNetworkImage(
                              imageUrl: t.imageUrl,
                              width: 60,
                              height: 60,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    t.mealType.displayName.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: isDark
                                          ? AppColors.accent
                                          : AppColors.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    t.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${t.calories} kcal • + Log',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.caloriesOrange,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Meal Categories Logged (Breakfast, Lunch, Dinner, Snack)
              ...MealType.values.map((type) {
                return Obx(() {
                  final meals = controller.getMealsByType(type);
                  final totalCalsForType = meals.fold<int>(
                    0,
                    (prev, element) => prev + element.calories,
                  );

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  type.displayName,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: isDark
                                        ? AppColors.darkTextPrimary
                                        : AppColors.lightTextPrimary,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? AppColors.darkCard
                                        : AppColors.primaryContainer,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    '$totalCalsForType kcal',
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
                            TextButton.icon(
                              icon: const Icon(Icons.add_rounded, size: 16),
                              label: const Text('Add'),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (ctx) => const AddMealDialog(),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      if (meals.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 4,
                          ),
                          child: CustomCard(
                            padding: const EdgeInsets.all(14),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.no_meals_rounded,
                                  size: 20,
                                  color: isDark
                                      ? AppColors.darkTextMuted
                                      : AppColors.lightTextMuted,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'No ${type.displayName.toLowerCase()} logged yet today.',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: isDark
                                        ? AppColors.darkTextSecondary
                                        : AppColors.lightTextSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: meals.length,
                          separatorBuilder: (ctx, i) =>
                              const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            final m = meals[index];
                            return CustomCard(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  AppNetworkImage(
                                    imageUrl: m.imageUrl,
                                    width: 48,
                                    height: 48,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          m.name,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          '${m.calories} kcal • P: ${m.proteinGrams.toStringAsFixed(0)}g • C: ${m.carbsGrams.toStringAsFixed(0)}g • F: ${m.fatGrams.toStringAsFixed(0)}g',
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
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete_outline_rounded,
                                      size: 18,
                                      color: AppColors.error,
                                    ),
                                    onPressed: () {
                                      controller.removeMeal(m.id);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      const SizedBox(height: 8),
                    ],
                  );
                });
              }),

              const SizedBox(height: 16),

              // Disclaimer
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.darkCard
                        : AppColors.primaryContainer.withAlpha(50),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.info_outline_rounded,
                        size: 16,
                        color: AppColors.waterBlue,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Nutrition details represent standard sample estimates and should not be used as medical dietary advice.',
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark
                                ? AppColors.darkTextMuted
                                : AppColors.lightTextMuted,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMacroRow({
    required String name,
    required double current,
    required double target,
    required Color color,
    required double progress,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Text(
              '${current.toStringAsFixed(0)} / ${target.toStringAsFixed(0)} g',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white.withAlpha(200),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white.withAlpha(20),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
          ),
        ),
      ],
    );
  }
}

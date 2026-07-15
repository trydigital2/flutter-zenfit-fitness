import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/wellness_controller.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/app_network_image.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_card.dart';
import '../../../core/widgets/section_header.dart';
import '../../../data/models/wellness_model.dart';

class WellnessScreen extends StatelessWidget {
  const WellnessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WellnessController>();
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
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mind & Wellness',
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
                          'Mindfulness, breathwork, and deep sleep',
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
                      icon: const Icon(
                        Icons.favorite_rounded,
                        color: AppColors.heartRed,
                      ),
                      onPressed: () => Get.toNamed(AppRoutes.favorites),
                    ),
                  ],
                ),
              ),

              // Daily Mood Check-In
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomCard(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'How are you feeling today?',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Obx(
                            () => Text(
                              controller.selectedMood.value,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: isDark
                                    ? AppColors.accent
                                    : AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: controller.moods.map((m) {
                          final label = m['label']!;
                          final emoji = m['emoji']!;
                          return Obx(() {
                            final isSelected =
                                controller.selectedMood.value == label;
                            return InkWell(
                              onTap: () => controller.setMood(label),
                              borderRadius: BorderRadius.circular(14),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? (isDark
                                            ? AppColors.accent.withAlpha(50)
                                            : AppColors.primaryContainer)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: isSelected
                                        ? (isDark
                                              ? AppColors.accent
                                              : AppColors.primary)
                                        : Colors.transparent,
                                    width: 1.5,
                                  ),
                                ),
                                child: Text(
                                  emoji,
                                  style: TextStyle(
                                    fontSize: isSelected ? 30 : 26,
                                  ),
                                ),
                              ),
                            );
                          });
                        }).toList(),
                      ),
                      const SizedBox(height: 12),
                      Obx(() {
                        final current = controller.moods.firstWhere(
                          (m) => m['label'] == controller.selectedMood.value,
                          orElse: () => controller.moods.first,
                        );
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.darkSurface
                                : AppColors.lightBg,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '💡 ${current['tip']}',
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.lightTextSecondary,
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // Interactive Box Breathing CTA Hero Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomCard(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2E1065), Color(0xFF1E1B4B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(
                    color: AppColors.mindfulPurple.withAlpha(80),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: AppColors.mindfulPurple.withAlpha(50),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.air_rounded,
                          color: Color(0xFFC084FC),
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Interactive Box Breathing',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '4-4-4-4 rhythm to relieve acute stress in under 3 minutes.',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(180),
                              ),
                            ),
                            const SizedBox(height: 12),
                            InkWell(
                              onTap: () => Get.toNamed(AppRoutes.breathing),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.accent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  'Begin Exercise →',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primaryDark,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Guided Meditation Library Section
              SectionHeader(
                title: 'Guided Sessions (10+)',
                subtitle: 'Mindfulness, sleep body scans, and soundscapes',
              ),

              // Categories Filter
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
                      final isSelected =
                          controller.selectedCategory.value == cat;
                      return ChoiceChip(
                        label: Text(cat),
                        selected: isSelected,
                        onSelected: (val) => controller.onCategorySelected(cat),
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
                      );
                    });
                  },
                ),
              ),

              const SizedBox(height: 14),

              // Sessions List
              Obx(() {
                final list = controller.filteredSessions;
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: list.length,
                  separatorBuilder: (ctx, i) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final s = list[index];
                    return CustomCard(
                      padding: const EdgeInsets.all(14),
                      onTap: () => _openMeditationPlayer(context, s),
                      child: Row(
                        children: [
                          AppNetworkImage(
                            imageUrl: s.imageUrl,
                            width: 64,
                            height: 64,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.mindfulPurple
                                            .withAlpha(isDark ? 50 : 25),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        s.category.toUpperCase(),
                                        style: const TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.mindfulPurple,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Obx(() {
                                      final isFav = controller.isFavorite(s.id);
                                      return GestureDetector(
                                        onTap: () =>
                                            controller.toggleFavorite(s.id),
                                        child: Icon(
                                          isFav
                                              ? Icons.favorite_rounded
                                              : Icons.favorite_border_rounded,
                                          size: 18,
                                          color: isFav
                                              ? AppColors.heartRed
                                              : (isDark
                                                    ? AppColors.darkTextMuted
                                                    : AppColors.lightTextMuted),
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  s.title,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'By ${s.instructor} • ${s.durationMinutes} min',
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
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _openMeditationPlayer(BuildContext context, WellnessModel session) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkBg : AppColors.lightBg,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            AppNetworkImage(
              imageUrl: session.imageUrl,
              width: 140,
              height: 140,
              borderRadius: BorderRadius.circular(24),
            ),
            const SizedBox(height: 20),
            Text(
              session.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              'Guided by ${session.instructor}',
              style: TextStyle(
                fontSize: 13,
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              session.description,
              style: TextStyle(
                fontSize: 13,
                height: 1.4,
                color: isDark
                    ? AppColors.darkTextMuted
                    : AppColors.lightTextMuted,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            // Fake Slider / Visualizer
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.volume_up_rounded, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Slider(
                    value: 0.35,
                    onChanged: (val) {},
                    activeColor: AppColors.accent,
                  ),
                ),
                Text(
                  '${(session.durationMinutes * 0.35).toInt()}:${(session.durationMinutes * 60 * 0.35 % 60).toInt().toString().padLeft(2, '0')}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: 'Pause Session',
              icon: Icons.pause_circle_rounded,
              variant: ButtonVariant.accent,
              width: double.infinity,
              onPressed: () => Get.back(),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

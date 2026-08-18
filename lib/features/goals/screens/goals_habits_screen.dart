import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/goals_controller.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../core/widgets/custom_card.dart';
import '../../../core/widgets/section_header.dart';
import '../../../data/models/goal_model.dart';

class GoalsHabitsScreen extends StatelessWidget {
  const GoalsHabitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GoalsController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final now = DateTime.now();
    final weekDays = List.generate(
      7,
      (i) => now.subtract(Duration(days: 6 - i)),
    );

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      appBar: AppBar(
        title: const Text('Goals & Habits'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            tooltip: 'Add Custom Habit',
            onPressed: () => _showAddHabitDialog(context, controller),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Daily Targets Section
            SectionHeader(
              title: 'Daily Targets',
              subtitle: 'Tap any target to customize your goals',
              padding: EdgeInsets.zero,
            ),
            const SizedBox(height: 12),
            Obx(
              () => ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.goals.length,
                separatorBuilder: (ctx, i) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final g = controller.goals[index];
                  return CustomCard(
                    padding: const EdgeInsets.all(16),
                    onTap: () => _showEditGoalDialog(context, controller, g),
                    child: Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: _getGoalColor(
                              g.type,
                            ).withAlpha(isDark ? 40 : 25),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            _getGoalIcon(g.type),
                            color: _getGoalColor(g.type),
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                g.title,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${g.currentValue.toInt()} / ${g.targetValue.toInt()} ${g.unit}',
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
                        Row(
                          children: [
                            Text(
                              '${(g.progressPercentage * 100).toInt()}%',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: _getGoalColor(g.type),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.edit_outlined, size: 16),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 28),

            // Weekly Habit Tracker
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SectionHeader(
                  title: 'Weekly Habits Tracker',
                  subtitle: 'Tap circles to mark daily completions',
                  padding: EdgeInsets.zero,
                ),
                TextButton.icon(
                  icon: const Icon(Icons.add_rounded, size: 16),
                  label: const Text('New Habit'),
                  onPressed: () => _showAddHabitDialog(context, controller),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Days Header
            Padding(
              padding: const EdgeInsets.only(left: 120, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: weekDays.map((d) {
                  final isToday = d.day == now.day && d.month == now.month;
                  return SizedBox(
                    width: 26,
                    child: Text(
                      DateFormatter.formatWeekday(d).substring(0, 1),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isToday ? FontWeight.w800 : FontWeight.w600,
                        color: isToday
                            ? AppColors.accent
                            : (isDark
                                  ? AppColors.darkTextMuted
                                  : AppColors.lightTextMuted),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 8),

            // Habits List
            Obx(
              () => ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.habits.length,
                separatorBuilder: (ctx, i) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final habit = controller.habits[index];
                  return CustomCard(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Color(
                              habit.colorHex,
                            ).withAlpha(isDark ? 50 : 25),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            IconData(
                              habit.iconCodePoint,
                              fontFamily: 'MaterialIcons',
                            ),
                            size: 16,
                            color: Color(habit.colorHex),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                habit.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                '${habit.currentStreak}d streak 🔥',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.streakGold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // 7 Day circles
                        Row(
                          children: weekDays.map((d) {
                            final isDone = habit.isCompletedOn(d);
                            return GestureDetector(
                              onTap: () =>
                                  controller.toggleHabitDay(habit.id, d),
                              child: Container(
                                width: 26,
                                height: 26,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: isDone
                                      ? Color(habit.colorHex)
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isDone
                                        ? Color(habit.colorHex)
                                        : (isDark
                                              ? AppColors.darkBorder
                                              : AppColors.lightBorder),
                                    width: 1.5,
                                  ),
                                ),
                                child: isDone
                                    ? const Icon(
                                        Icons.check_rounded,
                                        size: 14,
                                        color: Colors.white,
                                      )
                                    : null,
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditGoalDialog(
    BuildContext context,
    GoalsController controller,
    GoalModel goal,
  ) {
    final textCtrl = TextEditingController(
      text: goal.targetValue.toInt().toString(),
    );

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Edit ${goal.title} Target'),
        content: TextField(
          controller: textCtrl,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Target in ${goal.unit}',
            suffixText: goal.unit,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final val = double.tryParse(textCtrl.text) ?? goal.targetValue;
              controller.updateGoalTarget(goal.id, val);
              Navigator.pop(ctx);
            },
            child: const Text('Save Target'),
          ),
        ],
      ),
    );
  }

  void _showAddHabitDialog(BuildContext context, GoalsController controller) {
    final titleCtrl = TextEditingController();
    String selectedCat = 'Fitness';

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Create Custom Habit'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(
                labelText: 'Habit Title',
                hintText: 'e.g. Read 15 min, Cold Shower...',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleCtrl.text.trim().isNotEmpty) {
                controller.addCustomHabit(
                  title: titleCtrl.text.trim(),
                  category: selectedCat,
                  icon: Icons.check_circle_rounded,
                  color: AppColors.accent,
                );
                Navigator.pop(ctx);
              }
            },
            child: const Text('Create Habit'),
          ),
        ],
      ),
    );
  }

  Color _getGoalColor(GoalType type) {
    switch (type) {
      case GoalType.steps:
        return AppColors.accent;
      case GoalType.calories:
        return AppColors.caloriesOrange;
      case GoalType.water:
        return AppColors.waterBlue;
      case GoalType.activeMinutes:
        return Colors.amber;
    }
  }

  IconData _getGoalIcon(GoalType type) {
    switch (type) {
      case GoalType.steps:
        return Icons.directions_walk_rounded;
      case GoalType.calories:
        return Icons.local_fire_department_rounded;
      case GoalType.water:
        return Icons.water_drop_rounded;
      case GoalType.activeMinutes:
        return Icons.timer_outlined;
    }
  }
}

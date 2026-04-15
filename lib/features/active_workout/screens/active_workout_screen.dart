import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/active_workout_controller.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_card.dart';
import '../../../core/widgets/progress_ring.dart';

class ActiveWorkoutScreen extends StatelessWidget {
  const ActiveWorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ActiveWorkoutController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _confirmExit(context, controller);
        }
      },
      child: Scaffold(
        backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
        body: SafeArea(
          child: Obx(() {
            if (controller.workoutState.value == WorkoutState.completed) {
              return _buildCompletedView(context, controller);
            }

            final ex = controller.currentExercise;
            final isRunning =
                controller.workoutState.value == WorkoutState.inProgress;
            final isReady = controller.workoutState.value == WorkoutState.ready;

            return Column(
              children: [
                // Top Session Bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () => _confirmExit(context, controller),
                      ),
                      Column(
                        children: [
                          Text(
                            controller.workout.title,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: isDark
                                  ? AppColors.darkTextPrimary
                                  : AppColors.lightTextPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Exercise ${controller.currentExerciseIndex.value + 1} of ${controller.workout.exercises.length}',
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.lightTextSecondary,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        DateFormatter.formatDuration(
                          controller.totalElapsedSeconds.value,
                        ),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),

                // Linear Session Progress
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: controller.sessionProgress,
                      backgroundColor: isDark
                          ? AppColors.darkBorder
                          : AppColors.primaryContainer,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.accent,
                      ),
                      minHeight: 6,
                    ),
                  ),
                ),

                const Spacer(),

                // Giant Circular Timer / Counter
                ProgressRing(
                  progress: ex.isTimed
                      ? (controller.secondsRemaining.value / ex.durationSeconds)
                      : (controller.secondsRemaining.value / 45),
                  size: 200,
                  strokeWidth: 12,
                  primaryColor: AppColors.accent,
                  backgroundColor: isDark
                      ? AppColors.darkCard
                      : AppColors.primaryContainer.withAlpha(120),
                  centerChild: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        DateFormatter.formatDuration(
                          controller.secondsRemaining.value,
                        ),
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'monospace',
                          letterSpacing: -1,
                          color: isDark
                              ? AppColors.darkTextPrimary
                              : AppColors.lightTextPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isReady ? 'READY' : (isRunning ? 'ACTIVE' : 'PAUSED'),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.5,
                          color: isRunning
                              ? AppColors.accent
                              : (isReady
                                    ? Colors.amber
                                    : AppColors.caloriesOrange),
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Current Exercise Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: CustomCard(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          ex.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.lightTextPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.accent.withAlpha(isDark ? 40 : 25),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            ex.targetDisplay,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: isDark
                                  ? AppColors.accent
                                  : AppColors.primary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          ex.description,
                          style: TextStyle(
                            fontSize: 13,
                            height: 1.4,
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        if (ex.tips.isNotEmpty) ...[
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.info_outline_rounded,
                                size: 14,
                                color: Colors.amber,
                              ),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  ex.tips,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: isDark
                                        ? AppColors.darkTextMuted
                                        : AppColors.lightTextMuted,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                const Spacer(),

                // Bottom Navigation Controls
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Previous Button
                      IconButton.filledTonal(
                        onPressed: controller.currentExerciseIndex.value > 0
                            ? controller.previousExercise
                            : null,
                        icon: const Icon(Icons.skip_previous_rounded),
                        iconSize: 28,
                      ),

                      // Main Play / Pause Button
                      SizedBox(
                        width: 72,
                        height: 72,
                        child: FloatingActionButton(
                          backgroundColor: AppColors.accent,
                          foregroundColor: AppColors.primaryDark,
                          elevation: 2,
                          onPressed: () {
                            if (isReady) {
                              controller.startWorkout();
                            } else if (isRunning) {
                              controller.pauseWorkout();
                            } else {
                              controller.resumeWorkout();
                            }
                          },
                          child: Icon(
                            isRunning
                                ? Icons.pause_rounded
                                : Icons.play_arrow_rounded,
                            size: 38,
                          ),
                        ),
                      ),

                      // Skip / Next Button
                      IconButton.filledTonal(
                        onPressed: controller.nextExercise,
                        icon: const Icon(Icons.skip_next_rounded),
                        iconSize: 28,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  void _confirmExit(BuildContext context, ActiveWorkoutController controller) {
    controller.pauseWorkout();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Quit Workout?'),
        content: const Text(
          'Your active progress will be saved up to this exercise.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              controller.resumeWorkout();
            },
            child: const Text('Resume'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              controller.finishWorkout();
              Get.back();
            },
            child: const Text('End Session'),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedView(
    BuildContext context,
    ActiveWorkoutController controller,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final durationMin = (controller.totalElapsedSeconds.value / 60)
        .ceil()
        .clamp(1, 180);
    final ratio =
        (controller.completedExercisesCount.value /
                controller.workout.exercises.length)
            .clamp(0.1, 1.0);
    final burned = (controller.workout.caloriesBurned * ratio).round();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: AppColors.accent.withAlpha(40),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.emoji_events_rounded,
              color: AppColors.accent,
              size: 48,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Workout Completed! 🎉',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: isDark
                  ? AppColors.darkTextPrimary
                  : AppColors.lightTextPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Great job crushing "${controller.workout.title}". Your stats have been recorded!',
            style: TextStyle(
              fontSize: 14,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),

          // Summary Stats Cards
          Row(
            children: [
              Expanded(
                child: CustomCard(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.timer_outlined,
                        color: AppColors.accent,
                        size: 24,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '$durationMin min',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text('Duration', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomCard(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.local_fire_department_outlined,
                        color: AppColors.caloriesOrange,
                        size: 24,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '$burned kcal',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text('Burned', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 36),

          CustomButton(
            text: 'View Progress & History',
            variant: ButtonVariant.accent,
            width: double.infinity,
            onPressed: () {
              Get.offNamed(AppRoutes.progress);
            },
          ),
          const SizedBox(height: 12),
          CustomButton(
            text: 'Return to Dashboard',
            variant: ButtonVariant.secondary,
            width: double.infinity,
            onPressed: () {
              Get.offAllNamed(AppRoutes.main);
            },
          ),
        ],
      ),
    );
  }
}

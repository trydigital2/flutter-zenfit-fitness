import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/utils/hiit_interval_engine.dart';
import '../../../core/widgets/custom_card.dart';

class HiitIntervalTimerCard extends StatelessWidget {
  final HiitProtocolConfig config;
  final int elapsedSeconds;
  final bool isRunning;
  final VoidCallback onTogglePlay;
  final VoidCallback onReset;

  const HiitIntervalTimerCard({
    super.key,
    required this.config,
    required this.elapsedSeconds,
    required this.isRunning,
    required this.onTogglePlay,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final progress = HiitIntervalEngine.evaluateSessionProgress(
      config: config,
      elapsedSeconds: elapsedSeconds,
    );

    final phaseColor = switch (progress.phase) {
      HiitPhase.prep => AppColors.waterBlue,
      HiitPhase.work => AppColors.caloriesOrange,
      HiitPhase.rest => AppColors.accent,
      HiitPhase.completed => AppColors.accent,
    };

    final phaseLabel = switch (progress.phase) {
      HiitPhase.prep => 'GET READY',
      HiitPhase.work => '🔥 WORK',
      HiitPhase.rest => '💨 REST',
      HiitPhase.completed => '🎉 DONE',
    };

    final estCalories = HiitIntervalEngine.estimateCaloriesBurned(
      weightKg: 70.0,
      durationSeconds: elapsedSeconds,
      met: config.averageMet,
    );

    return CustomCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    config.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${config.workSeconds}s Work / ${config.restSeconds}s Rest · ${config.totalRounds} Sets',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: phaseColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: phaseColor, width: 1.2),
                ),
                child: Text(
                  phaseLabel,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: phaseColor,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Timer Centerpiece
          Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkBg : AppColors.lightBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      'ROUND',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${progress.currentRound}/${config.totalRounds}',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 36,
                  width: 1,
                  color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
                ),
                Column(
                  children: [
                    Text(
                      'TIME LEFT',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${progress.secondsLeftInPhase}s',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: phaseColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 36,
                  width: 1,
                  color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
                ),
                Column(
                  children: [
                    Text(
                      'CALORIES',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$estCalories',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.caloriesOrange,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Progress Linear Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress.progressRatio.clamp(0.0, 1.0),
              minHeight: 6,
              backgroundColor: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              valueColor: AlwaysStoppedAnimation<Color>(phaseColor),
            ),
          ),

          const SizedBox(height: 16),

          // Control Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onTogglePlay,
                  icon: Icon(
                    isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    size: 20,
                  ),
                  label: Text(isRunning ? 'PAUSE' : 'START INTERVAL'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              IconButton.outlined(
                onPressed: onReset,
                icon: const Icon(Icons.replay_rounded, size: 20),
                style: IconButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

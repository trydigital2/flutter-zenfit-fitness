import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/utils/cooldown_flexibility_engine.dart';
import '../../../core/widgets/custom_card.dart';

class CooldownFlexibilityCard extends StatelessWidget {
  final int elapsedSeconds;
  final bool isPlaying;
  final VoidCallback onToggle;
  final VoidCallback onNextPose;

  const CooldownFlexibilityCard({
    super.key,
    required this.elapsedSeconds,
    required this.isPlaying,
    required this.onToggle,
    required this.onNextPose,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final state = CooldownFlexibilityEngine.evaluateProgress(
      elapsedSeconds: elapsedSeconds,
    );

    final textColor = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final subtitleColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return CustomCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'POST-WORKOUT COOLDOWN',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Flexibility & Parasympathetic Reset',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${state.parasympatheticScore}% RECOVERED',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primaryDark,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Active Stretch Hero Box
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurface : AppColors.lightBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'POSE ${state.currentPoseIndex + 1} OF 5',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: subtitleColor,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      '${state.currentPose.holdDurationSeconds}s hold',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  state.currentPose.name,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Targets: ${state.currentPose.targetMuscle}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.accentDark,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  state.currentPose.instructions,
                  style: TextStyle(
                    fontSize: 12,
                    color: subtitleColor,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // Progress Bar & Controls
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: state.progressFraction,
                    minHeight: 8,
                    backgroundColor: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accent),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              IconButton(
                icon: Icon(
                  isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                  color: AppColors.primary,
                  size: 32,
                ),
                onPressed: onToggle,
                tooltip: isPlaying ? 'Pause Routine' : 'Resume Routine',
              ),
              IconButton(
                icon: const Icon(
                  Icons.skip_next_rounded,
                  color: AppColors.primary,
                  size: 28,
                ),
                onPressed: onNextPose,
                tooltip: 'Next Pose',
              ),
            ],
          ),
        ],
      ),
    );
  }
}


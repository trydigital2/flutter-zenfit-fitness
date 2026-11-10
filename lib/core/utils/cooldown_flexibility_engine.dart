class StretchPose {
  final String id;
  final String name;
  final String targetMuscle;
  final int holdDurationSeconds;
  final String instructions;

  const StretchPose({
    required this.id,
    required this.name,
    required this.targetMuscle,
    required this.holdDurationSeconds,
    required this.instructions,
  });
}

class CooldownRoutineState {
  final int totalDurationSeconds;
  final int completedSeconds;
  final int currentPoseIndex;
  final StretchPose currentPose;
  final double progressFraction;
  final int heartRateDropBpm;
  final int parasympatheticScore;
  final bool isRoutineFinished;

  const CooldownRoutineState({
    required this.totalDurationSeconds,
    required this.completedSeconds,
    required this.currentPoseIndex,
    required this.currentPose,
    required this.progressFraction,
    required this.heartRateDropBpm,
    required this.parasympatheticScore,
    required this.isRoutineFinished,
  });
}

class CooldownFlexibilityEngine {
  static const List<StretchPose> defaultFullBodyRoutine = [
    StretchPose(
      id: 'standing_quad',
      name: 'Standing Quad & Hip Stretch',
      targetMuscle: 'Quadriceps / Hip Flexors',
      holdDurationSeconds: 45,
      instructions: 'Keep knees aligned, pull heel toward glute, and tuck pelvis slightly.',
    ),
    StretchPose(
      id: 'downward_dog_calf',
      name: 'Downward Dog & Calf Pedal',
      targetMuscle: 'Calves & Hamstrings',
      holdDurationSeconds: 45,
      instructions: 'Drive heels gently toward the mat while pressing chest toward thighs.',
    ),
    StretchPose(
      id: 'pigeon_pose',
      name: 'Reclined Pigeon Pose',
      targetMuscle: 'Glutes & Piriformis',
      holdDurationSeconds: 60,
      instructions: 'Cross ankle over opposite knee, gently draw hamstring toward chest.',
    ),
    StretchPose(
      id: 'child_pose_lat',
      name: 'Child\'s Pose with Side Reach',
      targetMuscle: 'Lats & Thoracic Spine',
      holdDurationSeconds: 60,
      instructions: 'Sink hips to heels, walk hands diagonally to stretch the lateral back.',
    ),
    StretchPose(
      id: 'box_breathing',
      name: 'Parasympathetic Box Breathing',
      targetMuscle: 'Diaphragm & Autonomic Nervous System',
      holdDurationSeconds: 60,
      instructions: 'Inhale 4s, hold 4s, exhale 4s, hold 4s to rapidly down-regulate heart rate.',
    ),
  ];

  /// Evaluates progress and recovery markers through the cooldown routine.
  static CooldownRoutineState evaluateProgress({
    required int elapsedSeconds,
    List<StretchPose> poses = defaultFullBodyRoutine,
    int peakWorkoutHr = 168,
    int currentHr = 122,
  }) {
    final totalDuration = poses.fold<int>(0, (sum, p) => sum + p.holdDurationSeconds);
    final clampedElapsed = elapsedSeconds.clamp(0, totalDuration);

    int accumulated = 0;
    int currentIdx = 0;
    StretchPose activePose = poses.first;

    for (int i = 0; i < poses.length; i++) {
      final pose = poses[i];
      if (clampedElapsed < accumulated + pose.holdDurationSeconds || i == poses.length - 1) {
        currentIdx = i;
        activePose = pose;
        break;
      }
      accumulated += pose.holdDurationSeconds;
    }

    final drop = (peakWorkoutHr - currentHr).clamp(0, 100);
    // Score out of 100 based on HR drop and completed duration
    final durationScore = (clampedElapsed / totalDuration) * 50;
    final dropScore = (drop / 50.0).clamp(0.0, 1.0) * 50;
    final recoveryScore = (durationScore + dropScore).round();

    return CooldownRoutineState(
      totalDurationSeconds: totalDuration,
      completedSeconds: clampedElapsed,
      currentPoseIndex: currentIdx,
      currentPose: activePose,
      progressFraction: totalDuration > 0 ? clampedElapsed / totalDuration : 0.0,
      heartRateDropBpm: drop,
      parasympatheticScore: recoveryScore.clamp(0, 100),
      isRoutineFinished: clampedElapsed >= totalDuration,
    );
  }
}


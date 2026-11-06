enum HiitPhase { prep, work, rest, completed }

class HiitProtocolConfig {
  final String name;
  final String description;
  final int workSeconds;
  final int restSeconds;
  final int totalRounds;
  final int prepSeconds;
  final double averageMet;

  const HiitProtocolConfig({
    required this.name,
    required this.description,
    required this.workSeconds,
    required this.restSeconds,
    required this.totalRounds,
    this.prepSeconds = 5,
    this.averageMet = 8.5,
  });

  int get totalDurationSeconds {
    final roundDuration = workSeconds + restSeconds;
    return prepSeconds + (roundDuration * totalRounds) - (totalRounds > 0 ? restSeconds : 0);
  }

  static const tabata = HiitProtocolConfig(
    name: 'Tabata Protocol',
    description: 'High intensity 20s work / 10s rest across 8 explosive rounds',
    workSeconds: 20,
    restSeconds: 10,
    totalRounds: 8,
    prepSeconds: 5,
    averageMet: 10.0,
  );

  static const norwegian4x4 = HiitProtocolConfig(
    name: 'Norwegian 4x4',
    description: 'Aerobic threshold 4 min intervals with 3 min active recovery',
    workSeconds: 240,
    restSeconds: 180,
    totalRounds: 4,
    prepSeconds: 10,
    averageMet: 8.0,
  );

  static const quickBurn = HiitProtocolConfig(
    name: 'Quick Burn 30/15',
    description: 'Dynamic conditioning 30s work / 15s rest across 6 rounds',
    workSeconds: 30,
    restSeconds: 15,
    totalRounds: 6,
    prepSeconds: 5,
    averageMet: 8.5,
  );
}

class HiitIntervalEngine {
  HiitIntervalEngine._();

  /// Calculates estimated calorie burn during interval sessions.
  /// Formula: Calories = (MET * 3.5 * weightKg / 200) * durationMinutes
  static double estimateCaloriesBurned({
    required double weightKg,
    required int durationSeconds,
    required double met,
  }) {
    if (weightKg <= 0 || durationSeconds <= 0) return 0.0;
    final durationMinutes = durationSeconds / 60.0;
    final calories = (met * 3.5 * weightKg / 200.0) * durationMinutes;
    return (calories * 10).round() / 10.0;
  }

  /// Determines current phase and remaining seconds given elapsed time.
  static ({
    HiitPhase phase,
    int currentRound,
    int secondsLeftInPhase,
    double progressRatio,
  }) evaluateSessionProgress({
    required HiitProtocolConfig config,
    required int elapsedSeconds,
  }) {
    if (elapsedSeconds < config.prepSeconds) {
      final left = config.prepSeconds - elapsedSeconds;
      return (
        phase: HiitPhase.prep,
        currentRound: 1,
        secondsLeftInPhase: left,
        progressRatio: config.prepSeconds > 0 ? elapsedSeconds / config.prepSeconds : 1.0,
      );
    }

    int remaining = elapsedSeconds - config.prepSeconds;

    for (int r = 1; r <= config.totalRounds; r++) {
      final isLastRound = r == config.totalRounds;

      if (remaining < config.workSeconds) {
        final left = config.workSeconds - remaining;
        return (
          phase: HiitPhase.work,
          currentRound: r,
          secondsLeftInPhase: left,
          progressRatio: config.workSeconds > 0 ? remaining / config.workSeconds : 1.0,
        );
      }

      remaining -= config.workSeconds;

      if (!isLastRound) {
        if (remaining < config.restSeconds) {
          final left = config.restSeconds - remaining;
          return (
            phase: HiitPhase.rest,
            currentRound: r,
            secondsLeftInPhase: left,
            progressRatio: config.restSeconds > 0 ? remaining / config.restSeconds : 1.0,
          );
        }
        remaining -= config.restSeconds;
      }
    }

    return (
      phase: HiitPhase.completed,
      currentRound: config.totalRounds,
      secondsLeftInPhase: 0,
      progressRatio: 1.0,
    );
  }
}

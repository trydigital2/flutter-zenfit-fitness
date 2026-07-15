import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';

enum BreathPhase { inhale, holdIn, exhale, holdOut }

class BreathingExerciseScreen extends StatefulWidget {
  const BreathingExerciseScreen({super.key});

  @override
  State<BreathingExerciseScreen> createState() =>
      _BreathingExerciseScreenState();
}

class _BreathingExerciseScreenState extends State<BreathingExerciseScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;

  Timer? _timer;
  int _secondsLeftInPhase = 4;
  int _totalElapsedSeconds = 0;
  BreathPhase _currentPhase = BreathPhase.inhale;
  bool _isActive = false;

  final int phaseDuration = 4; // 4s box breathing

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: Duration(seconds: phaseDuration),
    );

    _scaleAnimation = Tween<double>(begin: 0.65, end: 1.15).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOutSine),
    );
  }

  void _start() {
    setState(() {
      _isActive = true;
    });
    _animController.forward(from: 0.0);
    _runTimer();
  }

  void _pause() {
    setState(() {
      _isActive = false;
    });
    _timer?.cancel();
    _animController.stop();
  }

  void _reset() {
    setState(() {
      _isActive = false;
      _secondsLeftInPhase = 4;
      _totalElapsedSeconds = 0;
      _currentPhase = BreathPhase.inhale;
    });
    _timer?.cancel();
    _animController.reset();
  }

  void _runTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        _totalElapsedSeconds++;
        if (_secondsLeftInPhase > 1) {
          _secondsLeftInPhase--;
        } else {
          _secondsLeftInPhase = phaseDuration;
          _advancePhase();
        }
      });
    });
  }

  void _advancePhase() {
    switch (_currentPhase) {
      case BreathPhase.inhale:
        _currentPhase = BreathPhase.holdIn;
        // Keep scale expanded
        break;
      case BreathPhase.holdIn:
        _currentPhase = BreathPhase.exhale;
        _animController.reverse(from: 1.0);
        break;
      case BreathPhase.exhale:
        _currentPhase = BreathPhase.holdOut;
        // Keep scale contracted
        break;
      case BreathPhase.holdOut:
        _currentPhase = BreathPhase.inhale;
        _animController.forward(from: 0.0);
        break;
    }
  }

  String get _phaseTitle {
    switch (_currentPhase) {
      case BreathPhase.inhale:
        return 'Inhale Deeply';
      case BreathPhase.holdIn:
        return 'Hold Breath';
      case BreathPhase.exhale:
        return 'Exhale Slowly';
      case BreathPhase.holdOut:
        return 'Hold Empty';
    }
  }

  String get _phaseSubtext {
    switch (_currentPhase) {
      case BreathPhase.inhale:
        return 'Fill your lungs with fresh calm air';
      case BreathPhase.holdIn:
        return 'Gently maintain full stillness';
      case BreathPhase.exhale:
        return 'Release all accumulated stress';
      case BreathPhase.holdOut:
        return 'Pause in tranquil quietude';
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : const Color(0xFFF1F8F4),
      appBar: AppBar(
        title: const Text('Box Breathing (4-4-4-4)'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              Text(
                'Vagus Nerve Regulation',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: isDark ? AppColors.accent : AppColors.primary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                _phaseTitle,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: isDark
                      ? AppColors.darkTextPrimary
                      : AppColors.lightTextPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _phaseSubtext,
                style: TextStyle(
                  fontSize: 14,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                ),
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              // Animated Breathing Sphere
              AnimatedBuilder(
                animation: _scaleAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      width: 220,
                      height: 220,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            AppColors.accent.withAlpha(isDark ? 160 : 180),
                            AppColors.primaryLight.withAlpha(
                              isDark ? 120 : 140,
                            ),
                            AppColors.primary.withAlpha(100),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.accent.withAlpha(
                              _isActive ? 80 : 30,
                            ),
                            blurRadius: 40,
                            spreadRadius: _isActive ? 15 : 5,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          '$_secondsLeftInPhase',
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),

              const Spacer(),

              // Timer & Session Duration
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkCard
                      : AppColors.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Total Time: ${_totalElapsedSeconds ~/ 60}:${(_totalElapsedSeconds % 60).toString().padLeft(2, '0')}',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: isDark ? AppColors.accent : AppColors.primary,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Controls
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton.filledTonal(
                    onPressed: _reset,
                    icon: const Icon(Icons.refresh_rounded),
                    iconSize: 26,
                  ),
                  const SizedBox(width: 24),
                  SizedBox(
                    width: 72,
                    height: 72,
                    child: FloatingActionButton(
                      backgroundColor: AppColors.accent,
                      foregroundColor: AppColors.primaryDark,
                      elevation: 3,
                      onPressed: () {
                        if (_isActive) {
                          _pause();
                        } else {
                          _start();
                        }
                      },
                      child: Icon(
                        _isActive
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        size: 38,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

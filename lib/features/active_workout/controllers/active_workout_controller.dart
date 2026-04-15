import 'dart:async';
import 'package:get/get.dart';
import '../../../data/models/workout_model.dart';
import '../../../data/models/exercise_model.dart';
import '../../../data/models/workout_history_model.dart';
import '../../../data/repositories/workout_repository.dart';
import '../../../data/repositories/activity_repository.dart';
import '../../home/controllers/home_controller.dart';

enum WorkoutState { ready, inProgress, paused, completed }

class ActiveWorkoutController extends GetxController {
  final WorkoutRepository _workoutRepo = Get.find<WorkoutRepository>();
  final ActivityRepository _activityRepo = Get.find<ActivityRepository>();

  late WorkoutModel workout;
  final currentExerciseIndex = 0.obs;
  final workoutState = WorkoutState.ready.obs;
  final secondsRemaining = 0.obs;
  final totalElapsedSeconds = 0.obs;
  final completedExercisesCount = 0.obs;

  Timer? _exerciseTimer;
  Timer? _totalSessionTimer;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is WorkoutModel) {
      workout = args;
    } else {
      workout = _workoutRepo.getAllWorkouts().first;
    }
    _setupCurrentExercise();
  }

  void _setupCurrentExercise() {
    final ex = currentExercise;
    if (ex.isTimed) {
      secondsRemaining.value = ex.durationSeconds;
    } else {
      // Rep-based: allocate default 45s or counter
      secondsRemaining.value = 45;
    }
  }

  ExerciseModel get currentExercise =>
      workout.exercises[currentExerciseIndex.value];

  bool get isLastExercise =>
      currentExerciseIndex.value >= workout.exercises.length - 1;

  double get sessionProgress =>
      (currentExerciseIndex.value + 1) / workout.exercises.length;

  void startWorkout() {
    workoutState.value = WorkoutState.inProgress;
    _startTimers();
  }

  void pauseWorkout() {
    workoutState.value = WorkoutState.paused;
    _cancelTimers();
  }

  void resumeWorkout() {
    workoutState.value = WorkoutState.inProgress;
    _startTimers();
  }

  void _startTimers() {
    _cancelTimers();

    _totalSessionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      totalElapsedSeconds.value++;
    });

    _exerciseTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 1) {
        secondsRemaining.value--;
      } else {
        // Automatically advance to next exercise or complete
        nextExercise();
      }
    });
  }

  void _cancelTimers() {
    _exerciseTimer?.cancel();
    _exerciseTimer = null;
    _totalSessionTimer?.cancel();
    _totalSessionTimer = null;
  }

  void nextExercise() {
    completedExercisesCount.value++;
    if (!isLastExercise) {
      currentExerciseIndex.value++;
      _setupCurrentExercise();
    } else {
      finishWorkout();
    }
  }

  void previousExercise() {
    if (currentExerciseIndex.value > 0) {
      currentExerciseIndex.value--;
      _setupCurrentExercise();
    }
  }

  Future<void> finishWorkout() async {
    _cancelTimers();
    workoutState.value = WorkoutState.completed;

    final durationMin = (totalElapsedSeconds.value / 60).ceil().clamp(1, 180);
    final ratio = (completedExercisesCount.value / workout.exercises.length)
        .clamp(0.1, 1.0);
    final burned = (workout.caloriesBurned * ratio).round();

    // Log to history
    final historyItem = WorkoutHistoryModel(
      id: 'wh_${DateTime.now().millisecondsSinceEpoch}',
      workoutId: workout.id,
      workoutTitle: workout.title,
      category: workout.category,
      completedAt: DateTime.now(),
      durationMinutes: durationMin,
      caloriesBurned: burned,
      exercisesCompleted: completedExercisesCount.value,
    );

    await _workoutRepo.logCompletedWorkout(historyItem);
    await _activityRepo.recordWorkoutCompletion(
      caloriesBurned: burned,
      durationMinutes: durationMin,
    );

    // Refresh home controller if active
    if (Get.isRegistered<HomeController>()) {
      Get.find<HomeController>().loadDashboardData();
    }
  }

  @override
  void onClose() {
    _cancelTimers();
    super.onClose();
  }
}

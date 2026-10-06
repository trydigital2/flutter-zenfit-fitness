import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/user_profile_model.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../core/services/storage_service.dart';
import '../../home/controllers/home_controller.dart';
import '../../../app/routes/app_routes.dart';

class ProfileController extends GetxController {
  final UserRepository _userRepo = Get.find<UserRepository>();
  final StorageService _storage = Get.find<StorageService>();

  final userProfile = Rxn<UserProfileModel>();
  final isDarkMode = false.obs;
  final workoutRemindersEnabled = true.obs;
  final waterRemindersEnabled = true.obs;
  final dailyGoalRemindersEnabled = true.obs;

  @override
  void onInit() {
    super.onInit();
    userProfile.value = _userRepo.getUserProfile();
    isDarkMode.value = _storage.isDarkMode;
  }

  Future<void> toggleTheme(bool value) async {
    isDarkMode.value = value;
    await _storage.setDarkMode(value);
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> updateProfile({
    required String name,
    required int age,
    required double heightCm,
    required double weightKg,
    required String fitnessLevel,
    required String fitnessGoal,
    required String unitSystem,
  }) async {
    final current = userProfile.value ?? _userRepo.getUserProfile();
    final updated = current.copyWith(
      name: name,
      age: age,
      heightCm: heightCm,
      weightKg: weightKg,
      fitnessLevel: fitnessLevel,
      fitnessGoal: fitnessGoal,
      unitSystem: unitSystem,
    );

    await _userRepo.updateProfile(updated);
    userProfile.value = updated;

    if (Get.isRegistered<HomeController>()) {
      Get.find<HomeController>().loadDashboardData();
    }
  }

  Future<void> resetDemoData() async {
    await _storage.resetAllData();
    userProfile.value = _userRepo.getUserProfile();
    isDarkMode.value = false;
    Get.changeThemeMode(ThemeMode.light);

    if (Get.isRegistered<HomeController>()) {
      Get.find<HomeController>().loadDashboardData();
    }

    Get.offAllNamed(AppRoutes.main);
  }
}

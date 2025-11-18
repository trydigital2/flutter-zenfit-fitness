import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/services/storage_service.dart';

class OnboardingController extends GetxController {
  final StorageService _storage = Get.find<StorageService>();
  final pageController = PageController();
  final currentPage = 0.obs;

  final List<Map<String, String>> pages = [
    {
      'title': 'Build Healthy Habits',
      'subtitle':
          'Transform your daily routine with seamless habit tracking, hydration reminders, and mindful breathing exercises.',
      'image': 'assets/images/onboarding_1.svg',
    },
    {
      'title': 'Train Smarter Every Day',
      'subtitle':
          'Discover personalized strength, cardio, and yoga sessions with real-time countdown timers and exercise coaching.',
      'image': 'assets/images/onboarding_2.svg',
    },
    {
      'title': 'Track Your Wellness Journey',
      'subtitle':
          'Visualize weekly progress, balanced macros, and calorie burn without needing third-party servers or complex setups.',
      'image': 'assets/images/onboarding_3.svg',
    },
  ];

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (currentPage.value < pages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      completeOnboarding();
    }
  }

  Future<void> completeOnboarding() async {
    await _storage.setHasSeenOnboarding(true);
    Get.offAllNamed(AppRoutes.main);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

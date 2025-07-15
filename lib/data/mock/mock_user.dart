import '../models/user_profile_model.dart';

class MockUser {
  MockUser._();

  static const UserProfileModel defaultUser = UserProfileModel(
    name: 'Alex Morgan',
    email: 'alex.morgan@zenfit.app',
    avatarUrl: 'assets/images/avatars/user_avatar.svg',
    age: 28,
    heightCm: 178.0,
    weightKg: 72.5,
    fitnessLevel: 'Intermediate',
    fitnessGoal: 'Muscle Tone & Endurance',
    preferredCategories: ['Strength', 'HIIT', 'Yoga'],
    unitSystem: 'Metric',
  );
}

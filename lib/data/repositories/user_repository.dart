import '../models/user_profile_model.dart';
import '../mock/mock_user.dart';
import '../../core/services/storage_service.dart';

class UserRepository {
  final StorageService _storage;

  UserRepository(this._storage);

  UserProfileModel getUserProfile() {
    final saved = _storage.getUserProfile();
    if (saved != null) return saved;
    const initial = MockUser.defaultUser;
    _storage.saveUserProfile(initial);
    return initial;
  }

  Future<void> updateProfile(UserProfileModel profile) async {
    await _storage.saveUserProfile(profile);
  }
}

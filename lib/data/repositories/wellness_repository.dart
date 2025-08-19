import '../models/wellness_model.dart';
import '../mock/mock_meditations.dart';
import '../../core/services/storage_service.dart';

class WellnessRepository {
  final StorageService _storage;

  WellnessRepository(this._storage);

  List<WellnessModel> getAllSessions() {
    return MockMeditations.sessions;
  }

  List<WellnessModel> getFeaturedSessions() {
    return MockMeditations.sessions.where((s) => s.isFeatured).toList();
  }

  List<WellnessModel> filterSessions({String? category, String? searchQuery}) {
    return MockMeditations.sessions.where((s) {
      if (category != null &&
          category.isNotEmpty &&
          category.toLowerCase() != 'all' &&
          s.category.toLowerCase() != category.toLowerCase()) {
        return false;
      }
      if (searchQuery != null && searchQuery.trim().isNotEmpty) {
        final q = searchQuery.toLowerCase().trim();
        final matchesTitle = s.title.toLowerCase().contains(q);
        final matchesDesc = s.description.toLowerCase().contains(q);
        final matchesInstructor = s.instructor.toLowerCase().contains(q);
        if (!matchesTitle && !matchesDesc && !matchesInstructor) {
          return false;
        }
      }
      return true;
    }).toList();
  }

  List<String> getFavoriteIds() {
    return _storage.getFavoriteMeditationIds();
  }

  Future<void> toggleFavorite(String sessionId) async {
    final list = _storage.getFavoriteMeditationIds();
    if (list.contains(sessionId)) {
      list.remove(sessionId);
    } else {
      list.add(sessionId);
    }
    await _storage.saveFavoriteMeditationIds(list);
  }

  bool isFavorite(String sessionId) {
    return _storage.getFavoriteMeditationIds().contains(sessionId);
  }

  List<WellnessModel> getFavoriteSessions() {
    final favIds = getFavoriteIds();
    return MockMeditations.sessions
        .where((s) => favIds.contains(s.id))
        .toList();
  }
}

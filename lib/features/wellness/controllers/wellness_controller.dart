import 'package:get/get.dart';
import '../../../data/models/wellness_model.dart';
import '../../../data/repositories/wellness_repository.dart';

class WellnessController extends GetxController {
  final WellnessRepository _wellnessRepo = Get.find<WellnessRepository>();

  final selectedCategory = 'All'.obs;
  final searchQuery = ''.obs;
  final filteredSessions = <WellnessModel>[].obs;
  final favoriteIds = <String>{}.obs;
  final selectedMood = 'Great'.obs;

  final categories = [
    'All',
    'Meditation',
    'Breathing',
    'Sleep',
    'Stress Relief',
  ];

  final moods = [
    {
      'label': 'Great',
      'emoji': '🤩',
      'tip': 'Channel this high energy into a challenging workout!',
    },
    {
      'label': 'Good',
      'emoji': '😊',
      'tip': 'A balanced mind creates effortless progress.',
    },
    {
      'label': 'Okay',
      'emoji': '😐',
      'tip': 'A brisk 10-minute walk can quickly elevate your mood.',
    },
    {
      'label': 'Tired',
      'emoji': '😴',
      'tip': 'Honor your recovery today with restorative yoga.',
    },
    {
      'label': 'Stressed',
      'emoji': '😰',
      'tip': 'Try 3 minutes of box breathing right now to reset.',
    },
  ];

  @override
  void onInit() {
    super.onInit();
    favoriteIds.addAll(_wellnessRepo.getFavoriteIds());
    applyFilters();
  }

  void onCategorySelected(String cat) {
    selectedCategory.value = cat;
    applyFilters();
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;
    applyFilters();
  }

  void applyFilters() {
    filteredSessions.value = _wellnessRepo.filterSessions(
      category: selectedCategory.value,
      searchQuery: searchQuery.value,
    );
  }

  bool isFavorite(String id) => favoriteIds.contains(id);

  Future<void> toggleFavorite(String id) async {
    await _wellnessRepo.toggleFavorite(id);
    if (favoriteIds.contains(id)) {
      favoriteIds.remove(id);
    } else {
      favoriteIds.add(id);
    }
  }

  void setMood(String mood) {
    selectedMood.value = mood;
  }
}

import '../models/wellness_model.dart';

class MockMeditations {
  MockMeditations._();

  static final List<WellnessModel> sessions = [
    const WellnessModel(
      id: 'med_01',
      title: 'Mindful Morning Awakening',
      description:
          'Set a grounded, intentional tone for your day with gentle breath awareness and positive visualization.',
      category: 'Meditation',
      durationMinutes: 10,
      instructor: 'Dr. Elena Vance',
      imageUrl:
          'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=800&auto=format&fit=crop&q=80',
      isFeatured: true,
      benefits:
          'Clears morning brain fog, reduces cortisol spike, improves focus.',
    ),
    const WellnessModel(
      id: 'med_02',
      title: '4-7-8 Deep Box Breathing',
      description:
          'A nervous-system regulating pranayama technique to instantly slow heart rate and reduce acute stress.',
      category: 'Breathing',
      durationMinutes: 5,
      instructor: 'Marcus Chen',
      imageUrl:
          'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=800&auto=format&fit=crop&q=80',
      isFeatured: true,
      benefits:
          'Stimulates the vagus nerve and lowers sympathetic drive in under 3 minutes.',
    ),
    const WellnessModel(
      id: 'med_03',
      title: 'Deep Slumber Body Scan',
      description:
          'Progressive neuromuscular release from crown to toes to quiet racing thoughts and induce restful deep sleep.',
      category: 'Sleep',
      durationMinutes: 20,
      instructor: 'Sarah Jenkins',
      imageUrl:
          'https://images.unsplash.com/photo-1511295742362-92c96b124e52?w=800&auto=format&fit=crop&q=80',
      isFeatured: true,
      benefits:
          'Promotes alpha-to-theta brainwave transition and improves sleep architecture.',
    ),
    const WellnessModel(
      id: 'med_04',
      title: 'Workday Stress Reset',
      description:
          'Release micro-tensions in the jaw, shoulders, and brow during intense deadlines and cognitive overload.',
      category: 'Stress Relief',
      durationMinutes: 8,
      instructor: 'David Thorne',
      imageUrl:
          'https://images.unsplash.com/photo-1499209974431-9dddcece7f88?w=800&auto=format&fit=crop&q=80',
      isFeatured: false,
      benefits: 'Resets cognitive fatigue and mitigates digital eye strain.',
    ),
    const WellnessModel(
      id: 'med_05',
      title: 'Loving-Kindness (Metta)',
      description:
          'Traditional Buddhist mindfulness practice cultivating compassion, goodwill, and emotional resilience.',
      category: 'Meditation',
      durationMinutes: 15,
      instructor: 'Ananya Sharma',
      imageUrl:
          'https://images.unsplash.com/photo-1470847355775-e0e3c35a9a2c?w=800&auto=format&fit=crop&q=80',
      isFeatured: false,
      benefits:
          'Enhances empathy, decreases negative self-talk, uplifts emotional baseline.',
    ),
    const WellnessModel(
      id: 'med_06',
      title: 'Coherent Resonance Breathing',
      description:
          'Maintain 5.5 breaths per minute cadence to harmonize heart rate variability (HRV) and respiratory cycles.',
      category: 'Breathing',
      durationMinutes: 10,
      instructor: 'Dr. Elena Vance',
      imageUrl:
          'https://images.unsplash.com/photo-1518241353330-0f7941c2d9b5?w=800&auto=format&fit=crop&q=80',
      isFeatured: false,
      benefits:
          'Optimizes blood oxygen saturation and autonomic nervous balance.',
    ),
    const WellnessModel(
      id: 'med_07',
      title: 'Rainforest Ambient Sleep Sounds',
      description:
          'Gentle tropical raindrops on broad leaves blended with soothing delta binaural frequencies.',
      category: 'Sleep',
      durationMinutes: 45,
      instructor: 'ZenFit Sound Lab',
      imageUrl:
          'https://images.unsplash.com/photo-1448375240586-882707db888b?w=800&auto=format&fit=crop&q=80',
      isFeatured: false,
      benefits:
          'Masks environmental noise and prolongs slow-wave restorative sleep.',
    ),
    const WellnessModel(
      id: 'med_08',
      title: 'Unplug & Decompress',
      description:
          'Post-commute psychological boundary meditation to transition smoothly from professional mode to home peace.',
      category: 'Stress Relief',
      durationMinutes: 12,
      instructor: 'Marcus Chen',
      imageUrl:
          'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&auto=format&fit=crop&q=80',
      isFeatured: false,
      benefits:
          'Dismantles lingering work anxieties and creates presence for loved ones.',
    ),
    const WellnessModel(
      id: 'med_09',
      title: 'Athlete Recovery Meditation',
      description:
          'Focus internal circulation and mental relaxation on fatigued muscle tissues following strenuous training.',
      category: 'Meditation',
      durationMinutes: 14,
      instructor: 'Coach Liam Reed',
      imageUrl:
          'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?w=800&auto=format&fit=crop&q=80',
      isFeatured: false,
      benefits:
          'Lowers post-exercise inflammatory markers and speeds muscle recovery.',
    ),
    const WellnessModel(
      id: 'med_10',
      title: 'Evening Sunset Gratitude',
      description:
          'Reflect on three daily wins, acknowledge personal growth, and close the day with peaceful contentment.',
      category: 'Meditation',
      durationMinutes: 7,
      instructor: 'Sarah Jenkins',
      imageUrl:
          'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=800&auto=format&fit=crop&q=80',
      isFeatured: false,
      benefits:
          'Rewires attention bias toward gratitude and positive memory consolidation.',
    ),
  ];
}

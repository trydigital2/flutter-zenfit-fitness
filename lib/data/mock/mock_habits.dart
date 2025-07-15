import 'package:flutter/material.dart';
import '../models/habit_model.dart';

class MockHabits {
  MockHabits._();

  static List<HabitModel> getDefaultHabits() {
    final now = DateTime.now();
    String dayKey(int daysAgo) {
      final d = now.subtract(Duration(days: daysAgo));
      return '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
    }

    return [
      HabitModel(
        id: 'habit_01',
        title: 'Morning Mobility & Stretch',
        category: 'Fitness',
        iconCodePoint: Icons.self_improvement.codePoint,
        colorHex: 0xFF10B981,
        completedDates: [
          dayKey(0), // Today
          dayKey(1),
          dayKey(2),
          dayKey(3),
          dayKey(4),
          dayKey(5),
          dayKey(6),
        ],
        targetDaysPerWeek: 7,
      ),
      HabitModel(
        id: 'habit_02',
        title: 'Drink 2.5L Clean Water',
        category: 'Health',
        iconCodePoint: Icons.water_drop_rounded.codePoint,
        colorHex: 0xFF0EA5E9,
        completedDates: [dayKey(1), dayKey(2), dayKey(3), dayKey(4), dayKey(5)],
        targetDaysPerWeek: 7,
      ),
      HabitModel(
        id: 'habit_03',
        title: '7+ Hours Restful Sleep',
        category: 'Health',
        iconCodePoint: Icons.bedtime_rounded.codePoint,
        colorHex: 0xFF8B5CF6,
        completedDates: [
          dayKey(0),
          dayKey(1),
          dayKey(2),
          dayKey(4),
          dayKey(5),
          dayKey(6),
        ],
        targetDaysPerWeek: 7,
      ),
      HabitModel(
        id: 'habit_04',
        title: '10,000 Daily Steps Walk',
        category: 'Fitness',
        iconCodePoint: Icons.directions_walk_rounded.codePoint,
        colorHex: 0xFFF59E0B,
        completedDates: [dayKey(1), dayKey(3), dayKey(4), dayKey(5)],
        targetDaysPerWeek: 5,
      ),
      HabitModel(
        id: 'habit_05',
        title: 'No Refined Sugar After 7 PM',
        category: 'Nutrition',
        iconCodePoint: Icons.restaurant_rounded.codePoint,
        colorHex: 0xFFEC4899,
        completedDates: [dayKey(0), dayKey(1), dayKey(2), dayKey(3)],
        targetDaysPerWeek: 6,
      ),
      HabitModel(
        id: 'habit_06',
        title: '10-Minute Breath Mindfulness',
        category: 'Mindfulness',
        iconCodePoint: Icons.spa_rounded.codePoint,
        colorHex: 0xFF14B8A6,
        completedDates: [dayKey(1), dayKey(2), dayKey(3), dayKey(5), dayKey(6)],
        targetDaysPerWeek: 7,
      ),
    ];
  }
}

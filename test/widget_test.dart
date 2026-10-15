import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenfit/core/services/storage_service.dart';
import 'package:zenfit/core/widgets/custom_button.dart';
import 'package:zenfit/core/widgets/metric_badge.dart';
import 'package:zenfit/core/widgets/section_header.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await StorageService().init();
  });

  group('ZenFit Widget Component Tests', () {
    testWidgets('CustomButton renders label and responds to tap', (
      WidgetTester tester,
    ) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              text: 'Start Workout',
              onPressed: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      expect(find.text('Start Workout'), findsOneWidget);
      await tester.tap(find.text('Start Workout'));
      await tester.pump();
      expect(tapped, true);
    });

    testWidgets('MetricBadge renders icon and label text', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MetricBadge(icon: Icons.timer_outlined, label: '28 min'),
          ),
        ),
      );

      expect(find.text('28 min'), findsOneWidget);
      expect(find.byIcon(Icons.timer_outlined), findsOneWidget);
    });

    testWidgets('SectionHeader displays title and action text', (
      WidgetTester tester,
    ) async {
      bool actionClicked = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SectionHeader(
              title: 'Recommended For You',
              actionText: 'See All',
              onActionTap: () {
                actionClicked = true;
              },
            ),
          ),
        ),
      );

      expect(find.text('Recommended For You'), findsOneWidget);
      expect(find.text('See All'), findsOneWidget);
      await tester.tap(find.text('See All'));
      await tester.pump();
      expect(actionClicked, true);
    });
  });
}

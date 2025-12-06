// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:football_app/features/onboarding/cubit/language_cubit.dart';
import 'package:football_app/features/onboarding/cubit/leagues_cubit.dart';
import 'package:football_app/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:football_app/features/onboarding/cubit/teams_cubit.dart';
import 'package:football_app/features/onboarding/cubit/timezone_cubit.dart';
import 'package:football_app/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Initialize LanguageCubit for testing
    final languageCubit = LanguageCubit();
    await languageCubit.initialize();

    // Initialize TimezoneCubit for testing
    final timezoneCubit = TimezoneCubit();
    await timezoneCubit.initialize();

    // Initialize LeaguesCubit for testing
    final leaguesCubit = LeaguesCubit();
    await leaguesCubit.initialize();

    // Initialize TeamsCubit for testing
    final teamsCubit = TeamsCubit();
    await teamsCubit.initialize();

    // Initialize OnboardingCubit for testing
    final onboardingCubit = OnboardingCubit();
    await onboardingCubit.initialize();

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      FootballApp(
        languageCubit: languageCubit,
        timezoneCubit: timezoneCubit,
        leaguesCubit: leaguesCubit,
        teamsCubit: teamsCubit,
        onboardingCubit: onboardingCubit,
      ),
    );

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sprint4_fix/features/home/presentation/view/setting_page/setting_page.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/setting_bloc/setting_bloc.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/setting_bloc/setting_state.dart';

// Mock Bloc
class MockSettingsBloc extends Mock implements SettingsBloc {
  @override
  Stream<SettingsState> get stream => Stream.empty();

  @override
  SettingsState get state =>
      SettingsInitial(); // Replace with actual initial state
}

void main() {
  late MockSettingsBloc mockSettingsBloc;

  setUp(() {
    mockSettingsBloc = MockSettingsBloc();
  });

  Widget createTestWidget() {
    return MaterialApp(
      home: BlocProvider<SettingsBloc>.value(
        value: mockSettingsBloc,
        child: const SettingsPage(),
      ),
    );
  }

  testWidgets('renders SettingsPage and verifies UI components',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());

    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Settings Hub'), findsOneWidget);
    expect(find.text('Personalize your experience'), findsOneWidget);
    expect(find.text('Appointments'), findsOneWidget);
    expect(find.text('Terms & Conditions'), findsOneWidget);
    expect(find.text('About'), findsOneWidget);
    expect(find.text('Logout'), findsOneWidget);
  });

  testWidgets('shows logout confirmation dialog', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());

    await tester.tap(find.text('Logout'));
    await tester.pumpAndSettle();

    expect(find.text('Confirm Logout'), findsOneWidget);
    expect(find.text('Are you sure you want to logout?'), findsOneWidget);
  });
}

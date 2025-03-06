import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sprint4_fix/features/home/presentation/view/term_conditions/term_condi.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/term_bloc/term_bloc.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/term_bloc/term_state.dart';

// Mock Bloc
class MockTermsBloc extends Mock implements TermsBloc {}

void main() {
  late MockTermsBloc mockTermsBloc;
  late StreamController<TermsState> stateController;

  setUp(() {
    mockTermsBloc = MockTermsBloc();
    stateController = StreamController<TermsState>();

    when(() => mockTermsBloc.stream).thenAnswer((_) => stateController.stream);
    when(() => mockTermsBloc.state).thenReturn(TermsInitial());
  });

  tearDown(() {
    stateController.close();
  });

  Widget createTestWidget() {
    return MaterialApp(
      home: BlocProvider<TermsBloc>.value(
        value: mockTermsBloc,
        child: const TermsPage(),
      ),
    );
  }

  testWidgets('renders TermsPage and verifies UI components',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());
    expect(find.text('Terms & Conditions'), findsOneWidget);
    expect(find.text('Our Legal Agreement'), findsOneWidget);
  });

  testWidgets('shows loading indicator initially', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('navigates back when return button is tapped',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    final returnButton = find.text('Return');
    expect(returnButton, findsOneWidget);

    await tester.tap(returnButton);
    await tester.pumpAndSettle();
  });
}

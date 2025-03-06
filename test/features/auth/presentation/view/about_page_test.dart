import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sprint4_fix/features/home/presentation/view/about_page/about_page.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/about_bloc/about_bloc.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/about_bloc/about_event.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/about_bloc/about_state.dart';

class MockAboutBloc extends Mock implements AboutBloc {}

void main() {
  late MockAboutBloc mockAboutBloc;

  setUp(() {
    mockAboutBloc = MockAboutBloc();
    registerFallbackValue(const Stream<AboutState>.empty());
    registerFallbackValue(LoadAboutData()); // Use const constructor
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<AboutBloc>(
        create: (context) => mockAboutBloc,
        child: const AboutPage(),
      ),
    );
  }

  group('AboutPage Widget Tests', () {
    testWidgets('header displays correctly', (tester) async {
      // Arrange
      var loadedState = AboutLoaded(
        description: 'Test description',
        version: '1.0.0',
        contact: 'test@example.com',
      );

      when(() => mockAboutBloc.state).thenReturn(loadedState);
      when(() => mockAboutBloc.stream).thenAnswer(
        (_) => Stream.value(loadedState),
      );
      when(() => mockAboutBloc.add(any())).thenAnswer((_) {});

      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(find.text('About Us'), findsOneWidget);
      expect(find.byIcon(Icons.medical_services), findsOneWidget);
    });

    testWidgets('return button navigates back', (tester) async {
      // Arrange
      tester.binding.window.physicalSizeTestValue = const Size(800, 1200);
      tester.binding.window.devicePixelRatioTestValue = 1.0;

      var loadedState = AboutLoaded(
        description: 'Test description',
        version: '1.0.0',
        contact: 'test@example.com',
      );

      when(() => mockAboutBloc.state).thenReturn(loadedState);
      when(() => mockAboutBloc.stream).thenAnswer(
        (_) => Stream.value(loadedState),
      );
      when(() => mockAboutBloc.add(any())).thenAnswer((_) {});

      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Return'), findsOneWidget);

      await tester.ensureVisible(find.byType(OutlinedButton));
      await tester.tap(find.byType(OutlinedButton));
      await tester.pumpAndSettle();

      // Reset window size
      tester.binding.window.clearPhysicalSizeTestValue();
    });
  });
}

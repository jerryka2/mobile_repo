import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sprint4_fix/features/auth/presentation/view/login_view.dart';
import 'package:sprint4_fix/features/auth/presentation/view/register_view.dart';
import 'package:sprint4_fix/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:sprint4_fix/features/auth/presentation/view_model/login/login_event.dart';
import 'package:sprint4_fix/features/auth/presentation/view_model/login/login_state.dart'; // ✅ Import login state

// ✅ Mock LoginBloc
class MockLoginBloc extends Mock implements LoginBloc {}

void main() {
  late MockLoginBloc mockLoginBloc;

  setUp(() {
    mockLoginBloc = MockLoginBloc();
    when(() => mockLoginBloc.stream).thenAnswer((_) => const Stream.empty());

    // ⬇️ Use the actual initial state name
    when(() => mockLoginBloc.state)
        .thenReturn(LoginInitialState()); // ✅ Use the correct name
  });

  Widget createTestableWidget(Widget child) {
    return MaterialApp(
      home: BlocProvider<LoginBloc>(
        create: (_) => mockLoginBloc,
        child: child,
      ),
    );
  }

  group('LoginView Widget Tests', () {
    testWidgets('renders LoginView with email and password fields',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(const LoginView()));

      expect(find.text('Prescipto'), findsOneWidget);
      expect(find.text('Log in to access your account'), findsOneWidget);
      expect(find.byType(TextFormField),
          findsNWidgets(2)); // Email & Password fields
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('validates empty email and password fields',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(const LoginView()));

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump(); // Rebuild UI after validation

      expect(find.text("Please enter your email"), findsOneWidget);
      expect(find.text("Please enter your password"), findsOneWidget);
    });

    testWidgets('triggers login event when valid input is entered',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(const LoginView()));

      final emailField = find.byType(TextFormField).first;
      final passwordField = find.byType(TextFormField).last;
      final loginButton = find.byType(ElevatedButton);

      await tester.enterText(emailField, 'test@example.com');
      await tester.enterText(passwordField, 'password123');
      await tester.tap(loginButton);
      await tester.pump();

      verify(() => mockLoginBloc.add(
            LogincustomerEvent(
              context: any(named: 'context'),
              email: 'test@example.com',
              password: 'password123',
            ),
          )).called(1);
    });

    testWidgets('navigates to RegisterView when Sign Up is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(const LoginView()));

      final signUpText = find.text("Sign Up");

      await tester.tap(signUpText);
      await tester.pumpAndSettle(); // Ensure navigation happens

      verify(() => mockLoginBloc.add(
            NavigateRegisterScreenEvent(
              destination: any(named: 'destination'),
              context: any(named: 'context'),
            ),
          )).called(1);
    });
  });
}

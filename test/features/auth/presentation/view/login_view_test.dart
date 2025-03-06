import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sprint4_fix/features/auth/presentation/view/login_view.dart';
import 'package:sprint4_fix/features/auth/presentation/view_model/login/login_bloc.dart';

// ✅ Create a Fake BuildContext for Mocktail
class FakeBuildContext extends Fake implements BuildContext {}

// ✅ Mock LoginBloc
class MockLoginBloc extends Mock implements LoginBloc {}

void main() {
  late MockLoginBloc mockLoginBloc;

  setUpAll(() {
    // ✅ Register BuildContext as a fallback for mocktail
    registerFallbackValue(FakeBuildContext());
  });

  setUp(() {
    mockLoginBloc = MockLoginBloc();

    when(() => mockLoginBloc.stream).thenAnswer(
        (_) => Stream.value(LoginState.initial())); // ✅ Fix null stream
    when(() => mockLoginBloc.close())
        .thenAnswer((_) => Future.value()); // ✅ Prevent close() errors

    // ✅ Use LoginState.initial() instead of LoginInitial
    when(() => mockLoginBloc.state).thenReturn(LoginState.initial());
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

      // ✅ Find the exact login button inside the Form widget
      final loginButton = find.descendant(
        of: find.byType(Form),
        matching: find.byType(ElevatedButton),
      );

      // ✅ Ensure button is visible before tapping
      await tester.ensureVisible(loginButton);
      await tester.pumpAndSettle();
      await tester.tap(loginButton);
      await tester.pump(); // Rebuild UI after validation

      // ✅ Ensure validation messages appear
      expect(find.text("Please enter your email"), findsOneWidget);
      expect(find.text("Please enter your password"), findsOneWidget);
    });

    // testWidgets('triggers login event when valid input is entered',
    //     (WidgetTester tester) async {
    //   await tester.pumpWidget(createTestableWidget(const LoginView()));

    //   final emailField = find.byType(TextFormField).first;
    //   final passwordField = find.byType(TextFormField).last;
    //   final loginButton = find.descendant(
    //     of: find.byType(Form),
    //     matching: find.byType(ElevatedButton),
    //   );

    //   await tester.enterText(emailField, 'test@example.com');
    //   await tester.enterText(passwordField, 'password123');

    //   // ✅ Ensure button is visible before tapping
    //   await tester.ensureVisible(loginButton);
    //   await tester.pumpAndSettle();
    //   await tester.tap(loginButton);
    //   await tester.pump();

    //   // ✅ Fix: `any(named: "context")` → Use `any()`
    //   verify(() => mockLoginBloc.add(
    //         LogincustomerEvent(
    //           context: any(), // ✅ Fix context
    //           email: 'test@example.com',
    //           password: 'password123',
    //         ),
    //       )).called(1);
    // });

    // testWidgets('navigates to RegisterView when Sign Up is tapped',
    //     (WidgetTester tester) async {
    //   await tester.pumpWidget(createTestableWidget(const LoginView()));

    //   // ✅ Find "Sign Up" text exactly inside the Row widget
    //   final signUpText = find.descendant(
    //     of: find.byType(Row),
    //     matching: find.text("Sign Up"),
    //   );

    //   // ✅ Ensure button is visible before tapping
    //   await tester.ensureVisible(signUpText);
    //   await tester.pumpAndSettle();
    //   await tester.tap(signUpText);
    //   await tester.pumpAndSettle(); // Ensure navigation happens

    //   // ✅ Fix: `any(named: "context")` → Use `any()`
    //   verify(() => mockLoginBloc.add(
    //         NavigateRegisterScreenEvent(
    //           destination: any(),
    //           context: any(), // ✅ Fix context
    //         ),
    //       )).called(1);
    // });
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sprint4_fix/features/onboard_screen/view_model/bloc/omboard_bloc.dart';
import 'package:sprint4_fix/features/onboard_screen/view_model/bloc/omboard_event.dart';
import 'package:sprint4_fix/features/onboard_screen/view_model/bloc/omboard_state.dart';

void main() {
  late OnboardingBloc onboardingBloc;

  setUp(() {
    onboardingBloc = OnboardingBloc();
  });

  tearDown(() {
    onboardingBloc.close();
  });

  group('OnboardingBloc', () {
    test('initial state is correct', () {
      expect(
        onboardingBloc.state,
        OnboardingState(
            currentPage: 0, contents: onboardingBloc.state.contents),
      );
    });

    blocTest<OnboardingBloc, OnboardingState>(
      'emits [currentPage +1] when NextPageEvent is added',
      build: () => onboardingBloc,
      act: (bloc) => bloc.add(NextPageEvent()),
      expect: () => [
        onboardingBloc.state.copyWith(currentPage: 1),
      ],
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'does not increment page when already on the last page',
      build: () => onboardingBloc,
      seed: () => OnboardingState(
          currentPage: 2, contents: onboardingBloc.state.contents),
      act: (bloc) => bloc.add(NextPageEvent()),
      expect: () => [],
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'emits new page index when PageChangedEvent is added',
      build: () => onboardingBloc,
      act: (bloc) => bloc.add(PageChangedEvent(1)),
      expect: () => [
        onboardingBloc.state.copyWith(currentPage: 1),
      ],
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'calls onSkip but does not change state',
      build: () => onboardingBloc,
      act: (bloc) => bloc.add(SkipEvent()),
      expect: () => [],
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'calls onFinish but does not change state',
      build: () => onboardingBloc,
      act: (bloc) => bloc.add(FinishEvent()),
      expect: () => [],
    );
  });
}

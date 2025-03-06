import 'package:bloc/bloc.dart';
import 'package:sprint4_fix/features/home/domain/entity/onboarding_content.dart';
import 'package:sprint4_fix/features/onboard_screen/view_model/bloc/omboard_event.dart';
import 'package:sprint4_fix/features/onboard_screen/view_model/bloc/omboard_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc()
      : super(OnboardingState(
          currentPage: 0,
          contents: [
            OnboardingContent(
              title: "Welcome to Prescipto",
              description: "Powering your future with sustainable energy.",
              imagePath: "assets/images/ev13.jpg",
            ),
            OnboardingContent(
              title: "Find Charging Stations",
              description: "Locate stations easily with Prescipto’s map.",
              imagePath: "assets/images/ev11.jpg",
            ),
            OnboardingContent(
              title: "Get Started",
              description: "Join Prescipto in the energy revolution!",
              imagePath: "assets/images/ev10.jpg",
            ),
          ],
        )) {
    on<NextPageEvent>(_onNextPage);
    on<SkipEvent>(_onSkip);
    on<PageChangedEvent>(_onPageChanged);
    on<FinishEvent>(_onFinish);
  }

  void _onNextPage(NextPageEvent event, Emitter<OnboardingState> emit) {
    if (!state.isLastPage) {
      emit(state.copyWith(currentPage: state.currentPage + 1));
    }
  }

  void _onSkip(SkipEvent event, Emitter<OnboardingState> emit) {
    // Navigate to the next screen (handled in UI)
  }

  void _onPageChanged(PageChangedEvent event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(currentPage: event.pageIndex));
  }

  void _onFinish(FinishEvent event, Emitter<OnboardingState> emit) {
    // Navigate to the next screen (handled in UI)
  }
}

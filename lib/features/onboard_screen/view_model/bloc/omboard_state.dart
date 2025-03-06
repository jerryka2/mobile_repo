import 'package:equatable/equatable.dart';
import 'package:sprint4_fix/features/home/domain/entity/onboarding_content.dart';

class OnboardingState extends Equatable {
  final int currentPage;
  final List<OnboardingContent> contents;

  const OnboardingState({
    required this.currentPage,
    required this.contents,
  });

  bool get isLastPage => currentPage == contents.length - 1;

  OnboardingState copyWith({
    int? currentPage,
    List<OnboardingContent>? contents,
  }) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      contents: contents ?? this.contents,
    );
  }

  @override
  List<Object> get props => [currentPage, contents];
}

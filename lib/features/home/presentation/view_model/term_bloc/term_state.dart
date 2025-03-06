abstract class TermsState {}

class TermsInitial extends TermsState {}

class TermsLoaded extends TermsState {
  final String terms;

  TermsLoaded({required this.terms});
}

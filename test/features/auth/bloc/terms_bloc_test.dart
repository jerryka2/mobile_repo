import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/term_bloc/term_bloc.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/term_bloc/term_event.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/term_bloc/term_state.dart';

void main() {
  late TermsBloc termsBloc;

  setUp(() {
    termsBloc = TermsBloc();
  });

  tearDown(() {
    termsBloc.close();
  });

  group('TermsBloc', () {
    test('initial state is TermsInitial', () {
      expect(termsBloc.state, isA<TermsInitial>());
    });

    blocTest<TermsBloc, TermsState>(
      'emits TermsLoaded when LoadTermsData is added',
      build: () => termsBloc,
      act: (bloc) => bloc.add(LoadTermsData()),
      expect: () => [
        isA<TermsLoaded>(), // Ensures the emitted state is TermsLoaded
      ],
      verify: (bloc) {
        final state = bloc.state;
        expect(state, isA<TermsLoaded>());
        if (state is TermsLoaded) {
          expect(state.terms, contains('Acceptance of Terms'));
          expect(state.terms, contains('Service Usage'));
          expect(state.terms, contains('Last updated: March 04, 2025.'));
        }
      },
    );
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/about_bloc/about_bloc.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/about_bloc/about_event.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/about_bloc/about_state.dart';

void main() {
  late AboutBloc aboutBloc;

  setUp(() {
    aboutBloc = AboutBloc();
  });

  tearDown(() {
    aboutBloc.close();
  });

  group('AboutBloc', () {
    test('initial state is AboutInitial', () {
      expect(aboutBloc.state, isA<AboutInitial>());
    });

    blocTest<AboutBloc, AboutState>(
      'emits AboutLoaded when LoadAboutData is added',
      build: () => aboutBloc,
      act: (bloc) => bloc.add(LoadAboutData()),
      expect: () => [
        isA<AboutLoaded>(), // Ensures the emitted state is AboutLoaded
      ],
      verify: (bloc) {
        final state = bloc.state;
        expect(state, isA<AboutLoaded>());
        if (state is AboutLoaded) {
          expect(state.version, equals('1.0.0'));
          expect(state.description, contains('Prescripto is your go-to app'));
          expect(state.contact, equals('support@prescripto.com'));
        }
      },
    );
  });
}

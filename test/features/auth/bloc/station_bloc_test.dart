import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sprint4_fix/features/home/data/datasource/home_remote_datasource.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/station_bloc/station_bloc.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/station_bloc/station_event.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/station_bloc/station_state.dart';

// ✅ Mock HomeRemoteDataSource
class MockHomeRemoteDataSource extends Mock implements HomeRemoteDataSource {}

void main() {
  late StationBloc stationBloc;
  late MockHomeRemoteDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockHomeRemoteDataSource();
    stationBloc = StationBloc(mockDataSource);
  });

  tearDown(() {
    stationBloc.close();
  });

  group('StationBloc', () {
    test('initial state is StationLoading', () {
      expect(stationBloc.state, isA<StationLoading>());
    });

    blocTest<StationBloc, StationState>(
      'emits [StationLoaded] when FetchStations is successful',
      build: () {
        when(() => mockDataSource.fetchStations()).thenAnswer(
          (_) async => [
            {
              "id": "1",
              "name": "Station A",
              "location": "City A",
            },
            {
              "id": "2",
              "name": "Station B",
              "location": "City B",
            },
          ], // ✅ Mocked List<Map<String, dynamic>>
        );
        return stationBloc;
      },
      act: (bloc) => bloc.add(FetchStations()),
      expect: () => [
        isA<StationLoaded>(),
      ],
      verify: (bloc) {
        final state = bloc.state;
        expect(state, isA<StationLoaded>());
        if (state is StationLoaded) {
          expect(state.stations, isA<List<Map<String, dynamic>>>());
          expect(state.stations.length, equals(2));
          expect(state.stations.first["name"], equals("Station A"));
        }
        verify(() => mockDataSource.fetchStations()).called(1);
      },
    );

    blocTest<StationBloc, StationState>(
      'emits [StationError] when FetchStations fails',
      build: () {
        when(() => mockDataSource.fetchStations())
            .thenThrow(Exception('Error fetching data'));
        return stationBloc;
      },
      act: (bloc) => bloc.add(FetchStations()),
      expect: () => [
        isA<StationError>(),
      ],
      verify: (bloc) {
        final state = bloc.state;
        expect(state, isA<StationError>());
        if (state is StationError) {
          expect(state.message, equals("Failed to fetch stations"));
        }
        verify(() => mockDataSource.fetchStations()).called(1);
      },
    );
  });
}

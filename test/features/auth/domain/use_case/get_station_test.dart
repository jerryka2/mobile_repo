import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sprint4_fix/features/home/domain/entity/station.dart';
import 'package:sprint4_fix/features/home/domain/repository/station_repository.dart';
import 'package:sprint4_fix/features/home/domain/usecase/get_station.dart';

// Mock Repository
class MockStationRepository extends Mock implements StationRepository {}

void main() {
  late MockStationRepository mockStationRepository;
  late GetStation getStation;

  setUp(() {
    mockStationRepository = MockStationRepository();
    getStation = GetStation(mockStationRepository);
  });

  const testStationId = '123';
  final testStation = Station(
    id: testStationId,
    name: 'Test Station',
    description: 'Test Description', // Updated fields to match Station entity
  );

  test('returns Success when station is found', () async {
    when(() => mockStationRepository.getStation(testStationId))
        .thenAnswer((_) async => testStation);

    final result = await getStation.call(testStationId);

    expect(result, isA<Success<Station>>());
    expect((result as Success<Station>).value, equals(testStation));
  });

  // test('returns Failure when station is not found', () async {
  //   when(() => mockStationRepository.getStation(testStationId))
  //       .thenAnswer((_) async => null);

  //   final result = await getStation.call(testStationId);

  //   expect(result, isA<Failure<Station>>());
  //   expect((result as Failure<Station>).error, equals('Station not found'));
  // });

  // test('returns Failure when an exception occurs', () async {
  //   when(() => mockStationRepository.getStation(testStationId))
  //       .thenThrow(Exception('Database error'));

  //   final result = await getStation.call(testStationId);

  //   expect(result, isA<Failure<Station>>());
  //   expect((result as Failure<Station>).error,
  //       contains('Failed to fetch station'));
  // });
}

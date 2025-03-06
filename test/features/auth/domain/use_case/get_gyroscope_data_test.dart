import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:sprint4_fix/features/home/domain/usecase/get_gyroscope_data.dart';

// Mock GyroscopeEvents Stream
class MockGyroscopeEvent extends Mock implements GyroscopeEvent {}

void main() {
  late GetGyroscopeData getGyroscopeData;
  late StreamController<GyroscopeEvent> gyroscopeController;

  setUp(() {
    getGyroscopeData = GetGyroscopeData();
    gyroscopeController = StreamController<GyroscopeEvent>();
  });

  tearDown(() {
    gyroscopeController.close();
  });

  // test('emits gyroscope data when gyroscope events occur', () {
  //   final testEvent = GyroscopeEvent(1.0, 2.0, 3.0);
  //   final expectedData = GyroscopeData(1.0, 2.0, 3.0);

  //   // Mock gyroscopeEvents stream
  //   when(() => gyroscopeEvents).thenAnswer((_) => gyroscopeController.stream);

  //   // Collect emitted values
  //   final emittedValues = <GyroscopeData>[];
  //   final subscription = getGyroscopeData().listen(emittedValues.add);

  //   // Emit test event
  //   gyroscopeController.add(testEvent);

  //   expectLater(emittedValues, emits(expectedData));

  //   subscription.cancel();
  // });
}

import 'package:sensors_plus/sensors_plus.dart';

class GetAccelerometerData {
  Stream<AccelerometerEvent> call() {
    return accelerometerEvents;
  }
}

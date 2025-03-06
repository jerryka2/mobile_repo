import 'package:sensors_plus/sensors_plus.dart';

class GyroscopeData {
  final double x;
  final double y;
  final double z;

  GyroscopeData(this.x, this.y, this.z);
}

class GetGyroscopeData {
  Stream<GyroscopeData> call() {
    return gyroscopeEvents
        .map((event) => GyroscopeData(event.x, event.y, event.z));
  }
}

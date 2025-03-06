// features/home/data/datasource/gyroscope_datasource.dart
import 'package:sensors_plus/sensors_plus.dart';

abstract class GyroscopeDataSource {
  Stream<GyroscopeEvent> getGyroscopeStream();
}

class GyroscopeDataSourceImpl implements GyroscopeDataSource {
  @override
  Stream<GyroscopeEvent> getGyroscopeStream() {
    return gyroscopeEvents;
  }
}

// features/home/domain/repository/gyroscope_repository.dart
import 'package:sensors_plus/sensors_plus.dart';
import 'package:sprint4_fix/features/home/data/datasource/gyroscope_datasource.dart';

abstract class GyroscopeRepository {
  Stream<GyroscopeEvent> getGyroscopeData();
}

class GyroscopeRepositoryImpl implements GyroscopeRepository {
  final GyroscopeDataSource dataSource;

  GyroscopeRepositoryImpl(this.dataSource);

  @override
  Stream<GyroscopeEvent> getGyroscopeData() {
    return dataSource.getGyroscopeStream();
  }
}

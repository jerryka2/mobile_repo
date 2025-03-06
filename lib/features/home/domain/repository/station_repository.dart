import 'package:sprint4_fix/features/home/domain/entity/station.dart';

abstract class StationRepository {
  Future<Station?> getStation(String stationId);
}
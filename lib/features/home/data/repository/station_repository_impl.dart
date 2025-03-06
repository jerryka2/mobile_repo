

import 'package:sprint4_fix/features/home/data/datasource/home_remote_datasource.dart';
import 'package:sprint4_fix/features/home/domain/entity/station.dart';
import 'package:sprint4_fix/features/home/domain/repository/station_repository.dart';

class StationRepositoryImpl implements StationRepository {
  final HomeRemoteDataSource remoteDataSource;

  StationRepositoryImpl(this.remoteDataSource);

  @override
  Future<Station?> getStation(String stationId) async {
    final model = await remoteDataSource.getStation(stationId);
    return model; // Model extends Station, so it’s compatible
  }
}
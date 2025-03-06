import 'package:sprint4_fix/features/home/domain/entity/station.dart';
import 'package:sprint4_fix/features/home/domain/repository/station_repository.dart';

sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T value;
  const Success(this.value);
}

class Failure<T> extends Result<T> {
  final String error;
  const Failure(this.error);
}

class GetStation {
  final StationRepository _repository;

  GetStation(this._repository);

  Future<Result<Station>> call(String stationId) async {
    try {
      final station = await _repository.getStation(stationId);
      if (station != null) {
        return Success(station);
      } else {
        return const Failure('Station not found');
      }
    } catch (e) {
      return Failure('Failed to fetch station: $e');
    }
  }
}

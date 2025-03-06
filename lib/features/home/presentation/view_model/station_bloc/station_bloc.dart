import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint4_fix/features/home/data/datasource/home_remote_datasource.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/station_bloc/station_event.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/station_bloc/station_state.dart';


// ✅ Create BLoC
class StationBloc extends Bloc<StationEvent, StationState> {
  final HomeRemoteDataSource _dataSource;

  StationBloc(this._dataSource) : super(StationLoading()) {
    on<FetchStations>(_fetchStations);
  }

  Future<void> _fetchStations(
      FetchStations event, Emitter<StationState> emit) async {
    try {
      final stations = await _dataSource.fetchStations();
      emit(StationLoaded(stations));
    } catch (e) {
      emit(StationError("Failed to fetch stations"));
    }
  }
}

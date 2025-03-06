import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/map_bloc/map_event.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/map_bloc/map_state.dart';

// State

// Bloc
class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState()) {
    on<InitializeMap>(_onInitializeMap);
    on<ToggleStationDetails>(_onToggleStationDetails);
    on<SelectStation>(_onSelectStation);
  }

  void _onInitializeMap(InitializeMap event, Emitter<MapState> emit) {
    emit(state.copyWith(isMapInitialized: true));
  }

  void _onToggleStationDetails(
      ToggleStationDetails event, Emitter<MapState> emit) {
    emit(state.copyWith(isShowingDetails: !state.isShowingDetails));
  }

  void _onSelectStation(SelectStation event, Emitter<MapState> emit) {
    emit(state.copyWith(selectedStation: event.stationName));
  }
}

// Events
abstract class MapEvent {}

class InitializeMap extends MapEvent {}

class ToggleStationDetails extends MapEvent {
  final String stationName;

  ToggleStationDetails(this.stationName);
}

class SelectStation extends MapEvent {
  final String stationName;

  SelectStation(this.stationName);
}

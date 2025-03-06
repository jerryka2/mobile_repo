class MapState {
  final bool isMapInitialized;
  final bool isShowingDetails;
  final String? selectedStation;
  final List<String> stations;

  MapState({
    this.isMapInitialized = false,
    this.isShowingDetails = false,
    this.selectedStation,
    this.stations = const [
      'Kathmandu Station',
      'Lalitpur Station',
      'Bhaktapur Station'
    ],
  });

  MapState copyWith({
    bool? isMapInitialized,
    bool? isShowingDetails,
    String? selectedStation,
    List<String>? stations,
  }) {
    return MapState(
      isMapInitialized: isMapInitialized ?? this.isMapInitialized,
      isShowingDetails: isShowingDetails ?? this.isShowingDetails,
      selectedStation: selectedStation ?? this.selectedStation,
      stations: stations ?? this.stations,
    );
  }
}

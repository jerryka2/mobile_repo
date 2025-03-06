import 'package:equatable/equatable.dart';

// ✅ Define Events
abstract class StationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchStations extends StationEvent {}

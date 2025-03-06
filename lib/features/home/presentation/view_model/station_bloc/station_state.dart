import 'package:equatable/equatable.dart';

// ✅ Define States
abstract class StationState extends Equatable {
  @override
  List<Object> get props => [];
}

class StationLoading extends StationState {}

class StationLoaded extends StationState {
  final List<dynamic> stations;
  StationLoaded(this.stations);

  @override
  List<Object> get props => [stations];
}

class StationError extends StationState {
  final String message;
  StationError(this.message);

  @override
  List<Object> get props => [message];
}

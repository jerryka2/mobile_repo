import 'package:equatable/equatable.dart';

sealed class NavbarBlocEvent with EquatableMixin {
  const NavbarBlocEvent();
}

class ChangePageEvent extends NavbarBlocEvent {
  final int pageIndex;
  const ChangePageEvent(this.pageIndex);

  @override
  List<Object> get props => [pageIndex];
}

class GyroscopeTiltEvent extends NavbarBlocEvent {
  final double xTilt;
  const GyroscopeTiltEvent(this.xTilt);

  @override
  List<Object> get props => [xTilt];
}

class AccelerometerShakeEvent extends NavbarBlocEvent {
  final double magnitude;
  const AccelerometerShakeEvent(this.magnitude);

  @override
  List<Object> get props => [magnitude];
}

import 'package:equatable/equatable.dart';

abstract class NavbarBlocState extends Equatable {
  final int selectedIndex;
  const NavbarBlocState(this.selectedIndex);

  @override
  List<Object> get props => [selectedIndex];
}

class NavbarInitial extends NavbarBlocState {
  const NavbarInitial(super.selectedIndex);
}

class NavbarPageChanged extends NavbarBlocState {
  const NavbarPageChanged(super.selectedIndex);
}

class NavbarLogout extends NavbarBlocState {
  // New state for logout
  const NavbarLogout() : super(0); // Default index, not used for logout
}

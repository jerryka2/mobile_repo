abstract class SettingsEvent {
  const SettingsEvent();
}

class ToggleDarkMode extends SettingsEvent {
  @override
  List<Object> get props => [];
}

class NavigateToTerms extends SettingsEvent {
  @override
  List<Object> get props => [];
}

class NavigateToAbout extends SettingsEvent {
  @override
  List<Object> get props => [];
}

class NavigateToAppointment extends SettingsEvent {
  @override
  List<Object> get props => [];
}

class LogoutEvent extends SettingsEvent {
  @override
  List<Object> get props => [];
}

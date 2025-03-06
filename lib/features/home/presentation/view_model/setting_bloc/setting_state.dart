class SettingsState {
  final bool isDarkMode;
  final String? destination;
  final String? error;
  final bool isLoggedOut; // Added

  const SettingsState({
    this.isDarkMode = false,
    this.destination,
    this.error,
    this.isLoggedOut = false, // Default to false
  });

  SettingsState copyWith({
    bool? isDarkMode,
    String? destination,
    String? error,
    bool? isLoggedOut,
  }) {
    return SettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      destination: destination ?? this.destination,
      error: error ?? this.error,
      isLoggedOut: isLoggedOut ?? this.isLoggedOut,
    );
  }

  @override
  List<Object?> get props => [isDarkMode, destination, error, isLoggedOut];
}

class SettingsInitial extends SettingsState {
  const SettingsInitial() : super();
}

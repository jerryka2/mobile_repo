import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint4_fix/features/home/data/datasource/home_remote_datasource.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/setting_bloc/setting_event.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/setting_bloc/setting_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final HomeRemoteDataSource _dataSource;

  SettingsBloc(this._dataSource) : super(const SettingsInitial()) {
    on<ToggleDarkMode>(_onToggleDarkMode);
    on<NavigateToTerms>(_onNavigateToTerms);
    on<NavigateToAbout>(_onNavigateToAbout);
    on<NavigateToAppointment>(_onNavigateToAppointment);
    on<LogoutEvent>(_onLogout);
  }

  void _onToggleDarkMode(ToggleDarkMode event, Emitter<SettingsState> emit) {
    emit(state.copyWith(isDarkMode: !state.isDarkMode));
  }

  void _onNavigateToTerms(NavigateToTerms event, Emitter<SettingsState> emit) {
    emit(state.copyWith(destination: '/terms'));
  }

  void _onNavigateToAbout(NavigateToAbout event, Emitter<SettingsState> emit) {
    emit(state.copyWith(destination: '/about'));
  }

  void _onNavigateToAppointment(
      NavigateToAppointment event, Emitter<SettingsState> emit) {
    emit(state.copyWith(destination: '/appointment'));
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<SettingsState> emit) async {
    try {
      emit(state.copyWith(
          destination: '/login',
          isLoggedOut: true,
          isDarkMode: false,
          error: null));
    } catch (e) {
      emit(state.copyWith(error: "Logout failed: $e"));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/about_bloc/about_event.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/about_bloc/about_state.dart';

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  AboutBloc() : super(AboutInitial()) {
    on<LoadAboutData>(_onLoadAboutData);
  }

  void _onLoadAboutData(LoadAboutData event, Emitter<AboutState> emit) {
    // Emit the AboutLoaded state with static data
    emit(AboutLoaded(
      version: '1.0.0',
      description:
          'Prescripto is your go-to app for reserving EV charging spots. '
          'We connect you with a vast network of charging stations worldwide, '
          'ensuring a seamless and efficient charging experience.',
      contact: 'support@prescripto.com',
    ));
  }
}

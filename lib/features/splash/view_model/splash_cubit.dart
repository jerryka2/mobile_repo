import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint4_fix/features/splash/view_model/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void startSplash({required BuildContext context}) {
    Future.delayed(const Duration(seconds: 2), () {
      emit(SplashLoaded());
      Navigator.pushReplacementNamed(context, '/onboarding');
    });
  }
}

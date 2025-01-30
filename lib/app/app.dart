import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint4_fix/app/di/di.dart';
import 'package:sprint4_fix/core/apptheme/app_theme.dart';
import 'package:sprint4_fix/features/auth/presentation/view/login_view.dart';
import 'package:sprint4_fix/features/auth/presentation/view_model/login/login_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Customer Management',
      theme: getApplicationTheme(),
      home: BlocProvider.value(
        value: getIt<LoginBloc>(),
        child: LoginView(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint4_fix/app/di/di.dart';
import 'package:sprint4_fix/core/apptheme/app_theme.dart';
import 'package:sprint4_fix/features/auth/presentation/view/login_view.dart';
import 'package:sprint4_fix/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:sprint4_fix/features/home/presentation/view/about_page/about_page.dart';
import 'package:sprint4_fix/features/home/presentation/view/appointment_page/appointment.dart';
import 'package:sprint4_fix/features/home/presentation/view/bottom_nav/nav_bottom.dart';
import 'package:sprint4_fix/features/home/presentation/view/map_page/map_page.dart';
import 'package:sprint4_fix/features/home/presentation/view/setting_page/setting_page.dart';
import 'package:sprint4_fix/features/home/presentation/view/term_conditions/term_condi.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/booking_bloc/booking_bloc.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/map_bloc/map_bloc.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/navbar_bloc/navbar_bloc_bloc.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/setting_bloc/setting_bloc.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/setting_bloc/setting_state.dart';
import 'package:sprint4_fix/features/onboard_screen/view/OnboardingScreen.dart';
import 'package:sprint4_fix/features/splash/view/splash_screen.dart';
import 'package:sprint4_fix/features/splash/view_model/splash_cubit.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    initDependencies().then((_) {
      setState(() {
        _isInitialized = true;
      });
    }).catchError((e) {
      print("Error initializing dependencies: $e");
      setState(() {
        _isInitialized = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<LoginBloc>()),
        BlocProvider(create: (context) => getIt<SplashCubit>()),
        BlocProvider(create: (context) => getIt<BookingBloc>()), // Use GetIt
        BlocProvider(create: (context) => getIt<MapBloc>()),
        BlocProvider(create: (context) => getIt<SettingsBloc>()),
        BlocProvider(create: (context) => getIt<NavbarBlocBloc>()), // Use GetIt
      ],
      child: Builder(
        builder: (context) {
          if (!_isInitialized) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ),
            );
          }

          WidgetsBinding.instance.addPostFrameCallback((_) {
            final splashCubit = context.read<SplashCubit>();
            splashCubit.startSplash(context: context);
          });

          return BlocBuilder<SettingsBloc, SettingsState>(
            buildWhen: (previous, current) =>
                previous.isDarkMode != current.isDarkMode,
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Prescipto',
                theme: getApplicationTheme(isDarkMode: state.isDarkMode),
                initialRoute: '/',
                routes: {
                  '/': (context) => const SplashView(),
                  '/onboarding': (context) => const OnboardingScreen(),
                  '/login': (context) => LoginView(),
                  '/home': (context) => NavigationRoot(
                        navbarBloc: context.read<NavbarBlocBloc>(),
                      ),
                  '/terms': (context) => const TermsPage(),
                  '/about': (context) => const AboutPage(),
                  '/map': (context) => MapScreen(),
                  '/appointment': (context) => AppointmentPage(),
                  '/settings': (context) => const SettingsPage(),
                },
                navigatorKey: GlobalKey<NavigatorState>(),
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint4_fix/app/di/di.dart';
import 'package:sprint4_fix/features/home/presentation/view/bottom_nav/nav_bottom.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/home_cubit.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/navbar_bloc/navbar_bloc_bloc.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/navbar_bloc/navbar_bloc_state.dart';
import 'package:sprint4_fix/features/home/presentation/widget/home_screen_content.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<HomeCubit>()),
        BlocProvider(create: (_) => getIt<NavbarBlocBloc>()),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello, Customer",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Welcome to Energize Nepal",
                    style: TextStyle(color: Colors.blue, fontSize: 14.0),
                  ),
                ],
              ),
              // _ProfileAvatar(),
            ],
          ),
          centerTitle: false,
        ),
        body: BlocListener<NavbarBlocBloc, NavbarBlocState>(
          listener: (context, state) {
            if (state is NavbarLogout) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Logging out..."),
                  duration: Duration(seconds: 1),
                ),
              );
              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.of(context).pushReplacementNamed('/login');
              });
            }
          },
          child: const HomeScreenContent(),
        ),
        bottomNavigationBar: BlocBuilder<NavbarBlocBloc, NavbarBlocState>(
          builder: (context, state) {
            return NavigationRoot(
              navbarBloc: context.read<NavbarBlocBloc>(),
            );
          },
        ),
      ),
    );
  }
}

// ✅ Fix: Correctly Displays the SVG Image
// class _ProfileAvatar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 48,
//       height: 48,
//       decoration: const BoxDecoration(
//         shape: BoxShape.circle,
//         color: Colors.white,
//       ),
//       child: ClipOval(
//         child: SvgPicture.asset(
//           'assets/images/logo.svg',
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }
// }

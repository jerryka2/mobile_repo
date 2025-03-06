import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sprint4_fix/features/splash/view_model/splash_cubit.dart';
import 'package:sprint4_fix/features/splash/view_model/splash_state.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  // Toggle between loading styles (true for circular, false for linear)
  static const bool _useCircularLoading = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward(); // Start the animation
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashLoaded) {
          Navigator.pushReplacementNamed(context, '/onboarding');
        }
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.green.shade100, Colors.white],
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: SvgPicture.asset(
                      'assets/images/logo.svg',
                      width: 60,
                      height: 60,
                      colorFilter: const ColorFilter.mode(
                        Colors.green,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: _useCircularLoading
                      ? SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            color: Colors.green,
                            strokeWidth: 5,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.green.withOpacity(0.8),
                            ),
                            backgroundColor: Colors.grey.shade200,
                          ),
                        )
                      : Container(
                          width: 200,
                          height: 6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.shade200,
                          ),
                          child: LinearProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.green.withOpacity(0.8),
                            ),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint4_fix/features/auth/presentation/view/login_view.dart';
import 'package:sprint4_fix/features/home/domain/entity/onboarding_content.dart';
import 'package:sprint4_fix/features/onboard_screen/view_model/bloc/omboard_bloc.dart';
import 'package:sprint4_fix/features/onboard_screen/view_model/bloc/omboard_event.dart';
import 'package:sprint4_fix/features/onboard_screen/view_model/bloc/omboard_state.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  late Animation<double> _buttonScaleAnimation;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _buttonScaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingBloc(),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.green.shade100, Colors.white],
            ),
          ),
          child: SafeArea(
            child: BlocConsumer<OnboardingBloc, OnboardingState>(
              listener: (context, state) {
                _pageController.animateToPage(
                  state.currentPage,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              builder: (context, state) {
                return Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: state.contents.length,
                        onPageChanged: (index) {
                          context
                              .read<OnboardingBloc>()
                              .add(PageChangedEvent(index));
                        },
                        itemBuilder: (context, index) {
                          return OnboardingPage(content: state.contents[index]);
                        },
                      ),
                    ),
                    _buildPageIndicator(state),
                    _buildButtons(context, state),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageIndicator(OnboardingState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          state.contents.length,
          (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 6.0),
            width: state.currentPage == index ? 24.0 : 8.0,
            height: 8.0,
            decoration: BoxDecoration(
              color: state.currentPage == index
                  ? Colors.green
                  : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context, OnboardingState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              context.read<OnboardingBloc>().add(SkipEvent());
              _navigateToDashboard(context);
            },
            child: AnimatedOpacity(
              opacity: state.isLastPage ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 300),
              child: const Text(
                "Skip",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          ScaleTransition(
            scale: _buttonScaleAnimation,
            child: ElevatedButton(
              onPressed: () {
                _animationController
                    .forward()
                    .then((_) => _animationController.reverse());
                if (state.isLastPage) {
                  context.read<OnboardingBloc>().add(FinishEvent());
                  _navigateToDashboard(context);
                } else {
                  context.read<OnboardingBloc>().add(NextPageEvent());
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                elevation: 5,
              ),
              child: Text(
                state.isLastPage ? "Get Started" : "Next",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToDashboard(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginView()),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final OnboardingContent content;

  const OnboardingPage({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                content.imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  print("Image load error: $error for ${content.imagePath}");
                  return const Icon(Icons.error, size: 100, color: Colors.red);
                },
              ),
            ),
          ),
          const SizedBox(height: 40),
          Text(
            content.title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            content.description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}

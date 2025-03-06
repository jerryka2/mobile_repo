import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/setting_bloc/setting_bloc.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/setting_bloc/setting_event.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.green.shade400,
              Colors.green.shade100,
              Colors.white,
            ],
            stops: const [0.0, 0.6, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context),
              Expanded(
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: ListView(
                    padding: const EdgeInsets.all(24.0),
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 40),
                      _buildAppointmentTile(context),
                      const SizedBox(height: 16),
                      _buildTermsTile(context),
                      const SizedBox(height: 16),
                      _buildAboutTile(context),
                      const SizedBox(height: 16),
                      _buildLogoutTile(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.green.shade500,
            Colors.green.shade300,
          ],
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.green.shade200.withOpacity(0.4),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Settings',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black26,
                  offset: Offset(1, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.green.shade700,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.green.shade300.withOpacity(0.4),
            blurRadius: 20,
            spreadRadius: 4,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Settings Hub',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Personalize your experience',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? iconColor,
    Color? textColor,
  }) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.green.withOpacity(0.3),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 12,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor ?? Colors.green.shade600,
              size: 30,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: textColor ?? Colors.black87,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey.shade400,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentTile(BuildContext context) {
    return _buildTile(
      icon: Icons.calendar_today,
      title: 'Appointments',
      onTap: () => _navigateTo(context, '/appointment'),
    );
  }

  Widget _buildTermsTile(BuildContext context) {
    return _buildTile(
      icon: Icons.description,
      title: 'Terms & Conditions',
      onTap: () => _navigateTo(context, '/terms'),
    );
  }

  Widget _buildAboutTile(BuildContext context) {
    return _buildTile(
      icon: Icons.info,
      title: 'About',
      onTap: () => _navigateTo(context, '/about'),
    );
  }

  Widget _buildLogoutTile(BuildContext context) {
    return _buildTile(
      icon: Icons.logout,
      title: 'Logout',
      iconColor: Colors.red.shade600,
      textColor: Colors.red.shade600,
      onTap: () async {
        final confirm = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Text('Confirm Logout'),
            content: const Text('Are you sure you want to logout?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child:
                    const Text('Logout', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        );
        if (confirm ?? false) {
          context.read<SettingsBloc>().add(LogoutEvent());
          _navigateToRoot(context, '/login', clearStack: true);
        }
      },
    );
  }

  void _navigateTo(BuildContext context, String route) {
    final rootNavigator = Navigator.of(context, rootNavigator: true);
    if (ModalRoute.of(context)?.settings.name != route) {
      rootNavigator.pushNamed(route);
    }
  }

  void _navigateToRoot(BuildContext context, String route,
      {bool clearStack = false}) {
    final rootNavigator = Navigator.of(context, rootNavigator: true);
    if (clearStack) {
      rootNavigator.pushNamedAndRemoveUntil(route, (route) => false);
    } else if (ModalRoute.of(context)?.settings.name != route) {
      rootNavigator.pushNamed(route);
    }
  }
}

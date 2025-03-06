import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint4_fix/features/home/presentation/view/map_page/map_page.dart'; // Correct import for StationPage
import 'package:sprint4_fix/features/home/presentation/view/setting_page/setting_page.dart';
import 'package:sprint4_fix/features/home/presentation/view/station_view/station_page.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/navbar_bloc/navbar_bloc_bloc.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/navbar_bloc/navbar_bloc_event.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/navbar_bloc/navbar_bloc_state.dart';
import 'package:sprint4_fix/features/home/presentation/widget/home_screen_content.dart';

class NavigationRoot extends StatefulWidget {
  final NavbarBlocBloc navbarBloc; // Add BLoC as a parameter
  const NavigationRoot({super.key, required this.navbarBloc});

  @override
  _NavigationRootState createState() => _NavigationRootState();
}

class _NavigationRootState extends State<NavigationRoot> {
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  // Removed 'const' since pages are not constant
  final List<Widget> _pages = [
    const HomeScreenContent(), // Made individual widgets const where possible
    const StationPage(),
    MapScreen(),
    const SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigatorKeys[0].currentState?.push(MaterialPageRoute(
            builder: (context) => _pages[0],
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.navbarBloc, // Provide the BLoC instance
      child: WillPopScope(
        onWillPop: () async {
          final navigator =
              _navigatorKeys[context.read<NavbarBlocBloc>().state.selectedIndex]
                  .currentState;
          if (navigator?.canPop() ?? false) {
            navigator?.pop();
            return false;
          }
          return true;
        },
        child: Scaffold(
          body: BlocBuilder<NavbarBlocBloc, NavbarBlocState>(
            builder: (context, state) {
              return IndexedStack(
                key: ValueKey(state.selectedIndex),
                index: state.selectedIndex, // Use BLoC state for index
                children: _pages.map((page) {
                  final index = _pages.indexOf(page);
                  return Navigator(
                    key: _navigatorKeys[index],
                    onGenerateRoute: (settings) {
                      return MaterialPageRoute(
                        builder: (context) => page,
                      );
                    },
                  );
                }).toList(),
              );
            },
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: BlocBuilder<NavbarBlocBloc, NavbarBlocState>(
              builder: (context, state) {
                return BottomNavigationBar(
                  selectedItemColor: Colors.green,
                  unselectedItemColor: Colors.grey,
                  showUnselectedLabels: true,
                  currentIndex: state.selectedIndex, // Sync with BLoC state
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white,
                  elevation: 8,
                  onTap: (index) {
                    context
                        .read<NavbarBlocBloc>()
                        .add(ChangePageEvent(index)); // Dispatch event to BLoC
                    if (_navigatorKeys[index].currentState?.canPop() ?? false) {
                      _navigatorKeys[index]
                          .currentState
                          ?.popUntil((route) => route.isFirst);
                    }
                  },
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home, size: 24),
                      label: "Home",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.local_gas_station, size: 24),
                      label: "Station",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.map, size: 24),
                      label: "Map",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings, size: 24),
                      label: "Settings",
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

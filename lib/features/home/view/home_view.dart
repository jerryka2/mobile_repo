// lib/features/home/presentation/view/home_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/home_cubit.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
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
              CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage('assets/images/logo.png'),
              ),
            ],
          ),
          centerTitle: false,
        ),
        body: const HomeScreenContent(),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: BottomNavigationBar(
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            currentIndex: context.watch<HomeCubit>().state.selectedIndex,
            onTap: (index) {
              context.read<HomeCubit>().onTabTapped(index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.location_on), label: "Location"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.qr_code_scanner), label: "Payment"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border), label: "Favorite"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Settings"),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 25),
          TextField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              suffixIcon: const Icon(Icons.filter_list, color: Colors.grey),
              hintText: 'Search',
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 35),
          const Text(
            "Our Brands",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBrandIcon('assets/images/mg.png', "MG"),
              _buildBrandIcon('assets/images/tata.png', "TATA"),
              _buildBrandIcon('assets/images/byd.png', "BYD"),
            ],
          ),
          const SizedBox(height: 35),
          const Text(
            "Popular Stations",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                  child: _buildStationCard("Electra Station", "Open - 24hr",
                      'assets/images/evstation.png')),
              const SizedBox(width: 10),
              Expanded(
                  child: _buildStationCard("Electra Station", "Open - 24hr",
                      'assets/images/evstation2.png')),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _buildBrandIcon(String imagePath, String label) {
    return Column(
      children: [
        Image.asset(imagePath, height: 60),
        const SizedBox(height: 5),
        Text(label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }

  static Widget _buildStationCard(
      String title, String status, String imagePath) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(imagePath,
                height: 120, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(status, style: const TextStyle(color: Colors.green)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sprint4_fix/features/home/data/datasource/home_remote_datasource.dart';
import 'package:sprint4_fix/features/home/presentation/view/booking_page/booking_page.dart';
import 'package:sprint4_fix/features/home/presentation/view/station_view/station_detail_page.dart';

class StationPage extends StatefulWidget {
  const StationPage({super.key});

  @override
  _StationPageState createState() => _StationPageState();
}

class _StationPageState extends State<StationPage>
    with SingleTickerProviderStateMixin {
  final HomeRemoteDataSource _dataSource = HomeRemoteDataSourceImpl();
  List<dynamic> _stations = [];
  bool _isLoading = true;
  String _errorMessage = "";
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
    _fetchStations();
  }

  void _fetchStations() async {
    try {
      List<dynamic> stations = await _dataSource.fetchStations();
      setState(() {
        _stations = stations;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Failed to fetch stations: ${e.toString()}";
        _isLoading = false;
      });
    }
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
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green.shade300,
              Colors.green.shade50,
              Colors.white,
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.green))
              : _errorMessage.isNotEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline,
                              size: 40, color: Colors.red),
                          const SizedBox(height: 12),
                          Text(
                            _errorMessage,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        _buildHeader(),
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(16.0),
                            itemCount: _stations.length,
                            itemBuilder: (context, index) {
                              final station = _stations[index];
                              return _buildStationCard(context, station, index);
                            },
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.green.shade600,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.green.shade300.withOpacity(0.5),
            blurRadius: 15,
            spreadRadius: 3,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Top EV Charging Stations",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Discover the best stations near you with real-time availability.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStationCard(BuildContext context, dynamic station, int index) {
    final String name = station['name']?.toString() ?? "Unnamed Station";
    final String imageUrl = station['image']?.toString() ?? "";
    final String powerCapacity =
        station['power_capacity']?.toString() ?? "Unknown";
    final String availability =
        station['availability']?.toString() ?? "Unknown";
    final Map<String, dynamic> address = station['address'] ?? {};
    final String fullAddress =
        "${address['line1'] ?? 'No Address'}, ${address['line2'] ?? ''}";

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset:
              Offset(0, 50 * (1 - _animationController.value) * (index % 5)),
          child: Opacity(
            opacity: _animationController.value,
            child: child,
          ),
        );
      },
      child: Card(
        elevation: 6,
        margin: const EdgeInsets.only(bottom: 16.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StationDetailPage(station: station),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: imageUrl.isNotEmpty
                          ? Image.network(
                              imageUrl,
                              height: 160,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return const SizedBox(
                                  height: 160,
                                  child: Center(
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2)),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                print("Station Image Load Error: $error");
                                return const SizedBox(
                                  height: 160,
                                  child: Center(
                                    child: Icon(Icons.broken_image,
                                        size: 40, color: Colors.grey),
                                  ),
                                );
                              },
                            )
                          : Container(
                              height: 160,
                              decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                child: Icon(Icons.ev_station,
                                    size: 40, color: Colors.green),
                              ),
                            ),
                    ),
                    if (availability.toLowerCase().contains("24/7"))
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            "24/7",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.bolt, size: 16, color: Colors.green),
                    const SizedBox(width: 4),
                    Text(
                      "$powerCapacity kW",
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on,
                        size: 16, color: Colors.green),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        fullAddress,
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingPage(station: station),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 4,
                    ),
                    child:
                        const Text("Book Now", style: TextStyle(fontSize: 14)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

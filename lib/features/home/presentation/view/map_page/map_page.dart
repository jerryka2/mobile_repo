import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  double _scale = 1.0; // Initial scale for zoom
  final double _zoomIncrement = 0.2; // Increment for zooming

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green.shade300.withOpacity(0.9),
              Colors.green.shade50.withOpacity(0.7),
              Colors.white,
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              _buildMapImage(),
              _buildAppBar(context),
              _buildStationMarkers(context),
              _buildZoomButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green.shade700,
              Colors.green.shade500,
            ],
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.green.shade200.withOpacity(0.6),
              blurRadius: 15,
              spreadRadius: 3,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const Expanded(
              child: Center(
                child: Text(
                  "EV Station Map",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.0,
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        offset: Offset(1, 1),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildMapImage() {
    return Center(
      child: Transform.scale(
        scale: _scale,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Image.asset(
            'assets/images/map_image.png', // Replace with your image path
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
          ),
        ),
      ),
    );
  }

  Widget _buildStationMarkers(BuildContext context) {
    final stations = [
      {
        'title': 'Kathmandu Station',
        'x': 0.5,
        'y': 0.3,
        'lat': 27.7172,
        'lng': 85.3240,
      },
      {
        'title': 'Lalitpur Station',
        'x': 0.4,
        'y': 0.5,
        'lat': 27.6700,
        'lng': 85.3100,
      },
      {
        'title': 'Bhaktapur Station',
        'x': 0.6,
        'y': 0.4,
        'lat': 27.7050,
        'lng': 85.2900,
      },
      {
        'title': 'Pokhara Station',
        'x': 0.3,
        'y': 0.6,
        'lat': 28.2096,
        'lng': 83.9856,
      },
      {
        'title': 'Biratnagar Station',
        'x': 0.7,
        'y': 0.7,
        'lat': 26.4499,
        'lng': 87.2718,
      },
    ];

    return IgnorePointer(
      child: Stack(
        children: stations.map((station) {
          final lat = station['lat'] as num? ?? 0.0;
          final lng = station['lng'] as num? ?? 0.0;
          return Positioned(
            left: MediaQuery.of(context).size.width * (station['x'] as double) -
                12, // Offset for pin center
            top: MediaQuery.of(context).size.height * (station['y'] as double) -
                30, // Offset for pin top
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    color: Colors.green.shade600.withOpacity(0.85),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26.withOpacity(0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Container(
                  width: 0,
                  height: 0,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.green.shade600.withOpacity(0.85),
                        width: 10,
                      ),
                      left:
                          const BorderSide(color: Colors.transparent, width: 5),
                      right:
                          const BorderSide(color: Colors.transparent, width: 5),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildZoomButtons() {
    return Positioned(
      bottom: 25,
      right: 25,
      child: Column(
        children: [
          FloatingActionButton(
            heroTag: 'zoomInButton',
            onPressed: () {
              setState(() {
                _scale = (_scale + _zoomIncrement).clamp(1.0, 3.0);
              });
            },
            backgroundColor: Colors.white,
            mini: true,
            elevation: 8,
            shape: const CircleBorder(),
            child: const Icon(
              Icons.add,
              color: Colors.green,
              size: 30,
            ),
          ),
          const SizedBox(height: 20),
          FloatingActionButton(
            heroTag: 'zoomOutButton',
            onPressed: () {
              setState(() {
                _scale = (_scale - _zoomIncrement).clamp(1.0, 3.0);
              });
            },
            backgroundColor: Colors.white,
            mini: true,
            elevation: 8,
            shape: const CircleBorder(),
            child: const Icon(
              Icons.remove,
              color: Colors.green,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}

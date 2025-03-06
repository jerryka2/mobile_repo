import 'package:flutter/material.dart';
import 'package:sprint4_fix/features/home/presentation/view/booking_page/booking_page.dart';

class StationDetailPage extends StatelessWidget {
  final dynamic station;

  const StationDetailPage({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    final String name = station['name']?.toString() ?? "Unnamed Station";
    final String imageUrl = station['image']?.toString() ?? "";
    final String powerCapacity =
        station['power_capacity']?.toString() ?? "Unknown";
    final String availability =
        station['availability']?.toString() ?? "Unknown";
    final Map<String, dynamic> address = station['address'] ?? {};
    final String fullAddress =
        "${address['line1'] ?? 'No Address'}, ${address['line2'] ?? ''}";

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                        color: Colors.black54,
                        blurRadius: 4,
                        offset: Offset(2, 2)),
                  ],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.white));
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.green.shade200,
                              child: const Center(
                                child: Icon(Icons.broken_image,
                                    size: 60, color: Colors.white),
                              ),
                            );
                          },
                        )
                      : Container(
                          color: Colors.green.shade200,
                          child: const Center(
                            child: Icon(Icons.ev_station,
                                size: 60, color: Colors.white),
                          ),
                        ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            backgroundColor: Colors.green,
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Power Capacity",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        "$powerCapacity kW",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Availability",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        availability,
                        style: TextStyle(
                          fontSize: 16,
                          color: availability.toLowerCase().contains("24/7")
                              ? Colors.green.shade700
                              : Colors.grey.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.location_on,
                          size: 20, color: Colors.green),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          fullAddress,
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[800]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Center(
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
                            horizontal: 40, vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 6,
                      ),
                      child: const Text(
                        "Book Appointment",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sprint4_fix/features/home/presentation/view/station_view/station_page.dart';

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
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
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const _HeaderSection(),
                const SizedBox(height: 40),
                const SectionTitle(title: "Find Our Brands"),
                const SizedBox(height: 8),
                const _BrandDescription(),
                const SizedBox(height: 16),
                _BrandScrollableRow(),
                const SizedBox(height: 40),
                const SectionTitle(title: "Popular Stations"),
                const SizedBox(height: 20),
                _PopularStationsList(),
                const SizedBox(height: 40),
                const SectionTitle(title: "Facilities"),
                const SizedBox(height: 20),
                const _FacilitiesSection(), // Added Facilities section
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Enhanced Header Section with Smaller Banner
class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.shade700, Colors.green.shade500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Text(
            "PRESCRIPTO",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontSize: 28,
                ),
          ),
        ),
        const SizedBox(height: 24),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/images/header_img.png',
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          "Charge with Ease",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
        ),
        const SizedBox(height: 12),
        Text(
          "Book your EV charging spot instantly!",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        const SizedBox(height: 30),
        _AnimatedBookNowButton(context),
      ],
    );
  }

  Widget _AnimatedBookNowButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const StationPage()),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade700, Colors.green.shade500],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          "Get Started",
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
        ),
      ),
    );
  }
}

// Reusable Section Title Widget
class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
    );
  }
}

// Added Brand Description (Smaller Text)
class _BrandDescription extends StatelessWidget {
  const _BrandDescription();

  @override
  Widget build(BuildContext context) {
    return Text(
      "Discover top EV brands we partner with for seamless charging.",
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey[700],
            fontSize: 12,
            height: 1.4,
          ),
    );
  }
}

// Fixed Brand Scrollable Row (Square, No Overflow)
class _BrandScrollableRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildBrandCard('assets/images/logo_tesla.png', 'Tesla'),
            const SizedBox(width: 16),
            _buildBrandCard('assets/images/mg.png', 'MG'),
            const SizedBox(width: 16),
            _buildBrandCard('assets/images/byd.png', 'BYD'),
            const SizedBox(width: 16),
            _buildBrandCard('assets/images/logo_audi.png', 'Audi'),
            const SizedBox(width: 16),
            _buildBrandCard('assets/images/logo_porsche.jpg', 'Porsche'),
            const SizedBox(width: 16),
            _buildBrandCard('assets/images/logo_kia.png', 'Kia'),
          ],
        ),
      ),
    );
  }

  static Widget _buildBrandCard(String imagePath, String label) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 50,
            width: 50,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// Simplified Popular Stations List
class _PopularStationsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 2,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: _buildStationCard(
            index == 0 ? "VoltCharge EV Hub" : "Himalayan Charge Station",
            index == 0
                ? "Fast Charging | 250 kW"
                : "Standard Charging | 120 kW",
            index == 0
                ? "27th Cross, Volt Drive, Energy District, London"
                : "37th Cross, Thamel, Kathmandu, Nepal",
            index == 0 ? 'assets/images/ev1.jpg' : 'assets/images/ev3.jpg',
            context,
          ),
        );
      },
    );
  }

  static Widget _buildStationCard(String title, String power, String location,
      String imagePath, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const StationPage()),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.asset(
                imagePath,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    power,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[700],
                        ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          size: 16, color: Colors.green.shade600),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          location,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Added Facilities Section
class _FacilitiesSection extends StatelessWidget {
  const _FacilitiesSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildFacilityTile(
            Icons.wifi, "Free Wi-Fi", "Stay connected while you charge."),
        const SizedBox(height: 12),
        _buildFacilityTile(
            Icons.local_cafe, "Cafe", "Grab a coffee or snack nearby."),
        const SizedBox(height: 12),
        _buildFacilityTile(
            Icons.wc, "Restrooms", "Clean facilities for your comfort."),
      ],
    );
  }

  static Widget _buildFacilityTile(
      IconData icon, String title, String description) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 28, color: Colors.green.shade600),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

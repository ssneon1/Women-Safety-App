import 'package:flutter/material.dart';
import '../utils/constants.dart';

class PoliceStationsScreen extends StatefulWidget {
  const PoliceStationsScreen({super.key});

  @override
  State<PoliceStationsScreen> createState() => _PoliceStationsScreenState();
}

class _PoliceStationsScreenState extends State<PoliceStationsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> _stations = [
    {
      'name': 'Central Police Station',
      'address': '1 MG Road, City Centre',
      'phone': '100',
      'distance': '0.8 km',
      'isOpen': true,
    },
    {
      'name': 'Women Police Station',
      'address': 'Sector 5, Safety Zone',
      'phone': '1091',
      'distance': '1.2 km',
      'isOpen': true,
    },
    {
      'name': 'North District Station',
      'address': 'North Avenue, Block A',
      'phone': '112',
      'distance': '2.1 km',
      'isOpen': true,
    },
    {
      'name': 'South Zone Police Post',
      'address': 'South Market, Near Metro',
      'phone': '100',
      'distance': '3.4 km',
      'isOpen': false,
    },
    {
      'name': 'East Precinct Office',
      'address': 'East Colony, Sector 12',
      'phone': '112',
      'distance': '4.0 km',
      'isOpen': true,
    },
    {
      'name': 'Highway Patrol Station',
      'address': 'NH-8, Bypass Road',
      'phone': '1800-180-1522',
      'distance': '5.5 km',
      'isOpen': true,
    },
  ];

  List<Map<String, dynamic>> get _filteredStations {
    if (_searchQuery.isEmpty) return _stations;
    return _stations.where((s) {
      final q = _searchQuery.toLowerCase();
      return (s['name'] as String).toLowerCase().contains(q) ||
          (s['address'] as String).toLowerCase().contains(q);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Police Stations'),
        backgroundColor: const Color(0xFFE91E63),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            color: const Color(0xFFE91E63),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: TextField(
              controller: _searchController,
              onChanged: (v) => setState(() => _searchQuery = v),
              decoration: InputDecoration(
                hintText: 'Search police stations...',
                prefixIcon: const Icon(Icons.search, color: Color(0xFFE91E63)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),

          // Emergency Call Banner
          Container(
            width: double.infinity,
            color: const Color(0xFFB71C1C),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Row(
              children: [
                const Icon(Icons.emergency, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                const Text(
                  'Emergency? Call  ',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    AppStrings.policeHelpline,
                    style: const TextStyle(
                      color: Color(0xFFB71C1C),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Station List
          Expanded(
            child: _filteredStations.isEmpty
                ? const Center(child: Text('No stations found'))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredStations.length,
                    itemBuilder: (context, index) {
                      return _buildStationCard(_filteredStations[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStationCard(Map<String, dynamic> station) {
    final isOpen = station['isOpen'] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.12),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE91E63).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.local_police,
                    color: Color(0xFFE91E63),
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        station['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        station['address'],
                        style: const TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isOpen ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    isOpen ? 'Open' : 'Closed',
                    style: TextStyle(
                      color: isOpen ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  station['distance'],
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
                const Spacer(),
                OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Calling ${station['name']}...'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.phone, size: 16),
                  label: Text(station['phone']),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFE91E63),
                    side: const BorderSide(color: Color(0xFFE91E63)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

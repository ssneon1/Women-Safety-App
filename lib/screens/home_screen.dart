import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import '../services/firebase_service.dart';
import '../services/location_service.dart';
import '../services/sos_service.dart';
import '../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  Position? _currentPosition;
  String _statusMessage = '📍 Getting location...';
  bool _isEmergency = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    
    _getLocation();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _getLocation() async {
    final locationService = LocationService();
    final position = await locationService.getCurrentPosition();
    setState(() {
      _currentPosition = position;
      _statusMessage = '✅ Location ready';
    });
  }

  void _triggerSOS() async {
    if (_currentPosition == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cannot get location. Please try again.')),
      );
      return;
    }

    setState(() => _isEmergency = true);

    // Show confirmation dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('🚨 SOS Alert', style: TextStyle(color: Colors.red)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Do you want to send an SOS?'),
              const SizedBox(height: 20),
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _pulseAnimation.value,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.warning, color: Colors.white, size: 30),
                    ),
                  );
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() => _isEmergency = false);
              },
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                Navigator.pop(context);
                
                // Call the SOS service
                final sosService = SOSService();
                await sosService.sendSOS(
                  userId: Provider.of<FirebaseService>(context, listen: false).userId,
                  latitude: _currentPosition!.latitude,
                  longitude: _currentPosition!.longitude,
                );

                // Navigate to SOS screen
                Navigator.pushNamed(context, '/sos');
                setState(() => _isEmergency = false);
              },
              child: const Text('SEND SOS', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '🛡️ Safety Shield',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings_outlined, size: 30),
                    onPressed: () => Navigator.pushNamed(context, '/settings'),
                  ),
                ],
              ),
              
              const SizedBox(height: 10),
              Text(
                _statusMessage,
                style: TextStyle(
                  color: _currentPosition != null ? Colors.green : Colors.orange,
                  fontSize: 14,
                ),
              ),
              
              const SizedBox(height: 40),
              
              // SOS Button
              Center(
                child: GestureDetector(
                  onTap: _triggerSOS,
                  child: AnimatedBuilder(
                    animation: _pulseAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _pulseAnimation.value,
                        child: Container(
                          width: 220,
                          height: 220,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const RadialGradient(
                              colors: [Color(0xFFE91E63), Color(0xFFC2185B)],
                              stops: [0.6, 1.0],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red.withOpacity(0.4),
                                blurRadius: 30,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.warning_amber_rounded, size: 70, color: Colors.white),
                                SizedBox(height: 10),
                                Text(
                                  'SOS',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 5,
                                  ),
                                ),
                                Text(
                                  'Emergency',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              
              const SizedBox(height: 50),
              
              // Quick Actions
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                childAspectRatio: 1.1,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [
                  _buildQuickAction(
                    icon: Icons.phone,
                    label: 'Police',
                    color: Colors.blue,
                    onTap: () => Navigator.pushNamed(context, '/police'),
                  ),
                  _buildQuickAction(
                    icon: Icons.contacts,
                    label: 'Emergency\nContacts',
                    color: Colors.orange,
                    onTap: () => Navigator.pushNamed(context, '/contacts'),
                  ),
                  _buildQuickAction(
                    icon: Icons.location_on,
                    label: 'Share Location',
                    color: Colors.green,
                    onTap: () => _shareLocation(),
                  ),
                  _buildQuickAction(
                    icon: Icons.mic,
                    label: 'Voice\nRecord',
                    color: Colors.purple,
                    onTap: () => _startVoiceRecording(),
                  ),
                  _buildQuickAction(
                    icon: Icons.medical_services,
                    label: 'First Aid\nTips',
                    color: Colors.teal,
                    onTap: () => _showFirstAidTips(),
                  ),
                  _buildQuickAction(
                    icon: Icons.people,
                    label: 'Nearby\nUsers',
                    color: Colors.indigo,
                    onTap: () => _showNearbyUsers(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _shareLocation() async {
    if (_currentPosition != null) {
      final locationLink = 
          'https://www.google.com/maps?q=${_currentPosition!.latitude},${_currentPosition!.longitude}';
      
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('📍 Share Location'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Share your location with emergency contacts?'),
              const SizedBox(height: 10),
              Text(
                locationLink,
                style: const TextStyle(color: Colors.blue, fontSize: 12),
                maxLines: 2,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Send SMS to emergency contacts
                _sendLocationSMS(locationLink);
              },
              child: const Text('Share Now'),
            ),
          ],
        ),
      );
    }
  }

  void _sendLocationSMS(String link) {
    // Implementation using flutter_sms package
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Location shared with emergency contacts!')),
    );
  }

  void _startVoiceRecording() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Voice recording started...')),
    );
  }

  void _showFirstAidTips() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('🩹 First Aid Tips'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('1. Stay calm and assess the situation'),
            SizedBox(height: 8),
            Text('2. Call for help immediately'),
            SizedBox(height: 8),
            Text('3. If bleeding, apply pressure'),
            SizedBox(height: 8),
            Text('4. Keep the person warm and comfortable'),
            SizedBox(height: 8),
            Text('5. Do not move if spinal injury is suspected'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showNearbyUsers() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Searching for nearby app users...')),
    );
  }
}
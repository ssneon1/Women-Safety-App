import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _sosVibration = true;
  bool _locationSharing = true;
  bool _nearbyAlerts = true;
  bool _autoCall = false;
  String _userName = '';
  String _userEmail = '';
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _sosVibration = prefs.getBool('sos_vibration') ?? true;
      _locationSharing = prefs.getBool('location_sharing') ?? true;
      _nearbyAlerts = prefs.getBool('nearby_alerts') ?? true;
      _autoCall = prefs.getBool('auto_call') ?? false;
      _userName = prefs.getString('userName') ?? 'User';
      _userEmail = prefs.getString('userEmail') ?? '';
      _loading = false;
    });
  }

  Future<void> _saveSetting(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color(0xFFE91E63),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Card
                  _buildProfileCard(),
                  const SizedBox(height: 24),

                  // SOS Settings
                  _buildSectionHeader('🚨 SOS Settings'),
                  _buildSwitchTile(
                    title: 'SOS Vibration',
                    subtitle: 'Vibrate phone during SOS activation',
                    icon: Icons.vibration,
                    value: _sosVibration,
                    onChanged: (v) {
                      setState(() => _sosVibration = v);
                      _saveSetting('sos_vibration', v);
                    },
                  ),
                  _buildSwitchTile(
                    title: 'Auto-call Emergency',
                    subtitle: 'Automatically call ${AppStrings.emergencyNumber} when SOS is triggered',
                    icon: Icons.call,
                    value: _autoCall,
                    onChanged: (v) {
                      setState(() => _autoCall = v);
                      _saveSetting('auto_call', v);
                    },
                  ),

                  const SizedBox(height: 24),

                  // Location Settings
                  _buildSectionHeader('📍 Location Settings'),
                  _buildSwitchTile(
                    title: 'Location Sharing',
                    subtitle: 'Share location with emergency contacts during SOS',
                    icon: Icons.location_on,
                    value: _locationSharing,
                    onChanged: (v) {
                      setState(() => _locationSharing = v);
                      _saveSetting('location_sharing', v);
                    },
                  ),
                  _buildSwitchTile(
                    title: 'Nearby Alerts',
                    subtitle: 'Get notified when someone nearby triggers SOS',
                    icon: Icons.near_me,
                    value: _nearbyAlerts,
                    onChanged: (v) {
                      setState(() => _nearbyAlerts = v);
                      _saveSetting('nearby_alerts', v);
                    },
                  ),

                  const SizedBox(height: 24),

                  // About
                  _buildSectionHeader('ℹ️ About'),
                  _buildInfoTile(
                    title: 'App Version',
                    subtitle: '1.0.0',
                    icon: Icons.info_outline,
                  ),
                  _buildInfoTile(
                    title: 'Emergency Helplines',
                    subtitle: 'Police: ${AppStrings.policeHelpline} | Women: ${AppStrings.womenHelpline}',
                    icon: Icons.phone_in_talk,
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE91E63), Color(0xFFC2185B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white.withOpacity(0.3),
            child: Text(
              _userName.isNotEmpty ? _userName[0].toUpperCase() : 'U',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _userName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (_userEmail.isNotEmpty)
                Text(
                  _userEmail,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 13,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xFFE91E63),
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SwitchListTile(
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFFE91E63),
        secondary: Icon(icon, color: const Color(0xFFE91E63)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFFE91E63)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ),
    );
  }
}

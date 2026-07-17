import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:telephony/telephony.dart';
import 'location_service.dart';
import 'notification_service.dart';

class SOSService {
  final LocationService _locationService = LocationService();
  final NotificationService _notificationService = NotificationService();
  final Telephony telephony = Telephony.instance;

  Future<void> sendSOS({
    required String userId,
    required double latitude,
    required double longitude,
  }) async {
    try {
      // 1. Log emergency event locally
      if (kDebugMode) {
        debugPrint(
          '[SOSService] 🚨 SOS triggered by $userId at ($latitude, $longitude)',
        );
      }

      // 2. Save active SOS to local storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('sos_active', true);
      await prefs.setDouble('sos_latitude', latitude);
      await prefs.setDouble('sos_longitude', longitude);
      await prefs.setString('sos_userId', userId);
      await prefs.setString(
        'sos_timestamp',
        DateTime.now().toIso8601String(),
      );

      // 3. Get emergency contacts from local storage and notify
      final contactsJson = prefs.getString('emergency_contacts_json');
      List<Map<String, String>> contacts = [];
      if (contactsJson != null) {
        final List<dynamic> decoded = jsonDecode(contactsJson);
        contacts = decoded.map<Map<String, String>>((e) => Map<String, String>.from(e)).toList();
      }
      
      final userName = prefs.getString('userName') ?? 'A user';

      // 4. Send background SMS (only on mobile)
      String mapsLink = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
      String smsMessage = '🚨 EMERGENCY: $userName needs help! Location: $mapsLink';
      
      for (final contact in contacts) {
        final phone = contact['phone'];
        if (phone != null && phone.isNotEmpty) {
          if (!kIsWeb) {
            try {
              await telephony.sendSms(
                to: phone,
                message: smsMessage,
              );
              if (kDebugMode) debugPrint('[SOSService] SMS sent to $phone');
            } catch (e) {
              if (kDebugMode) debugPrint('[SOSService] Failed to send SMS to $phone: $e');
            }
          } else {
            if (kDebugMode) debugPrint('[SOSService] Web platform: SMS simulation to $phone');
          }
        }

        // Also send push notification (existing code)
        await _notificationService.sendNotification(
          token: 'local',
          title: '🚨 SOS Alert!',
          body: '$userName needs help!',
          data: {
            'latitude': latitude.toString(),
            'longitude': longitude.toString(),
            'userId': userId,
          },
        );
      }

      // 5. Initiate direct phone call to the first contact (only on mobile)
      if (contacts.isNotEmpty && !kIsWeb) {
        final firstPhone = contacts.first['phone'];
        if (firstPhone != null && firstPhone.isNotEmpty) {
          try {
            await FlutterPhoneDirectCaller.callNumber(firstPhone);
            if (kDebugMode) debugPrint('[SOSService] Calling $firstPhone');
          } catch (e) {
            if (kDebugMode) debugPrint('[SOSService] Failed to call $firstPhone: $e');
          }
        }
      } else if (kIsWeb) {
        if (kDebugMode) debugPrint('[SOSService] Web platform: Direct call simulation.');
      }

      if (kDebugMode) {
        debugPrint('[SOSService] SOS sent to ${contacts.length} contacts.');
      }
    } catch (e) {
      throw Exception('Failed to send SOS: $e');
    }
  }

  Future<void> cancelSOS() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('sos_active', false);
    if (kDebugMode) {
      debugPrint('[SOSService] SOS cancelled.');
    }
  }

  Future<bool> isSOSActive() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('sos_active') ?? false;
  }
}

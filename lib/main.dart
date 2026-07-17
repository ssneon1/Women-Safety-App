import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/sos_screen.dart';
import 'screens/emergency_contacts.dart';
import 'screens/police_stations.dart';
import 'screens/settings_screen.dart';
import 'services/firebase_service.dart';
import 'services/notification_service.dart';
import 'models/user_model.dart';

import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Request necessary permissions for SOS (SMS and Phone) only on mobile platforms
  if (!kIsWeb) {
    await [
      Permission.sms,
      Permission.phone,
    ].request();
  }

  // Initialize Notification Service
  await NotificationService().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FirebaseService()),
        ChangeNotifierProvider(create: (_) => UserModel()),
      ],
      child: MaterialApp(
        title: 'Women Safety App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFFE91E63),
          scaffoldBackgroundColor: const Color(0xFFF8F9FA),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFE91E63),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFE91E63),
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE91E63),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        home: const HomeScreen(),
        routes: {
          '/sos': (context) => const SOSScreen(),
          '/contacts': (context) => const EmergencyContactsScreen(),
          '/police': (context) => const PoliceStationsScreen(),
          '/settings': (context) => const SettingsScreen(),
        },
      ),
    );
  }
}
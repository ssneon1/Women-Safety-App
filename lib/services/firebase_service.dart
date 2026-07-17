import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// FirebaseService manages user authentication state.
/// Note: Firebase packages currently have web-incompatible versions,
/// so this uses local SharedPreferences as a mock/fallback.
class FirebaseService extends ChangeNotifier {
  String? _userId;
  String? _userName;
  bool _isLoggedIn = false;

  String get userId => _userId ?? 'guest_user';
  String? get userName => _userName;
  bool get isLoggedIn => _isLoggedIn;

  FirebaseService() {
    _loadUserFromPrefs();
  }

  Future<void> _loadUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _userId = prefs.getString('userId');
    _userName = prefs.getString('userName');
    _isLoggedIn = _userId != null;
    notifyListeners();
  }

  Future<String?> signUp(String email, String password, String name) async {
    try {
      // Generate a local user ID
      final userId = 'user_${DateTime.now().millisecondsSinceEpoch}';
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', userId);
      await prefs.setString('userName', name);
      await prefs.setString('userEmail', email);

      _userId = userId;
      _userName = name;
      _isLoggedIn = true;
      notifyListeners();
      return null; // Success
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> signIn(String email, String password) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedEmail = prefs.getString('userEmail');

      if (savedEmail == email) {
        _userId = prefs.getString('userId');
        _userName = prefs.getString('userName');
        _isLoggedIn = true;
        notifyListeners();
        return null; // Success
      }
      return 'Invalid credentials';
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('userName');
    await prefs.remove('userEmail');
    _userId = null;
    _userName = null;
    _isLoggedIn = false;
    notifyListeners();
  }
}

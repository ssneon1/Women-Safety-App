import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  String? _id;
  String? _name;
  String? _email;
  String? _phone;
  double? _latitude;
  double? _longitude;
  bool _isActive = false;

  String? get id => _id;
  String? get name => _name;
  String? get email => _email;
  String? get phone => _phone;
  double? get latitude => _latitude;
  double? get longitude => _longitude;
  bool get isActive => _isActive;

  void updateUser({
    String? id,
    String? name,
    String? email,
    String? phone,
    double? latitude,
    double? longitude,
    bool? isActive,
  }) {
    _id = id ?? _id;
    _name = name ?? _name;
    _email = email ?? _email;
    _phone = phone ?? _phone;
    _latitude = latitude ?? _latitude;
    _longitude = longitude ?? _longitude;
    _isActive = isActive ?? _isActive;
    notifyListeners();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'name': _name,
      'email': _email,
      'phone': _phone,
      'latitude': _latitude,
      'longitude': _longitude,
      'isActive': _isActive,
    };
  }
}
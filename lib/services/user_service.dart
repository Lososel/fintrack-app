import 'package:flutter/material.dart';

class UserService {
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal();

  String? _name;
  String? _email;
  String? _location;
  String? _profileImagePath;
  double? _latitude;
  double? _longitude;

  String? get name => _name;
  String? get email => _email;
  String? get location => _location ?? "Unknown";
  String? get profileImagePath => _profileImagePath;
  double? get latitude => _latitude;
  double? get longitude => _longitude;

  void setUser(String name, String email) {
    _name = name;
    _email = email;
    notifyListeners();
  }

  void setLocation(String location, double? latitude, double? longitude) {
    _location = location;
    _latitude = latitude;
    _longitude = longitude;
    notifyListeners();
  }

  void setProfileImage(String? imagePath) {
    _profileImagePath = imagePath;
    notifyListeners();
  }

  void clearUser() {
    _name = null;
    _email = null;
    _location = null;
    _profileImagePath = null;
    _latitude = null;
    _longitude = null;
    notifyListeners();
  }

  final List<VoidCallback> _listeners = [];

  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  void notifyListeners() {
    for (var listener in _listeners) {
      listener();
    }
  }
}

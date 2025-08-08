import 'package:flutter/material.dart';
import '../services/profile_service.dart';

class UserProvider with ChangeNotifier {
  Map<String, dynamic>? _userData;

  Map<String, dynamic>? get userData => _userData;

  bool get isLoaded => _userData != null;

  Future<void> loadUserData() async {
    _userData = await getUserDetails();
    notifyListeners();
  }

  void clearUserData() {
    _userData = null;
    notifyListeners();
  }
}

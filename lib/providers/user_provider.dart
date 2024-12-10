import 'package:flutter/material.dart';
import 'package:myapp/entities/user.dart';

class UserProvider extends ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;

  void loginUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  void logoutUser() {
    _currentUser = null;
    notifyListeners();
  }
}

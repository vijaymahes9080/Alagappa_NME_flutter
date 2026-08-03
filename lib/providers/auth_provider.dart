import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/mock_data.dart';

class AuthProvider extends ChangeNotifier {
  User? _currentUser;
  bool _isAuthenticated = false;

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;
  UserRole? get userRole => _currentUser?.role;

  AuthProvider() {
    // Default logged in as Student for fast preview, or can switch
    loginAsDemoRole(UserRole.STUDENT);
  }

  void loginAsDemoRole(UserRole role) {
    _currentUser = MockData.initialUsers.firstWhere(
      (u) => u.role == role,
      orElse: () => MockData.initialUsers.last,
    );
    _isAuthenticated = true;
    notifyListeners();
  }

  bool loginWithCredentials(String email, String password) {
    final found = MockData.initialUsers.firstWhere(
      (u) => u.email.toLowerCase() == email.toLowerCase(),
      orElse: () => User(
        id: '',
        email: '',
        name: '',
        role: UserRole.STUDENT,
        departmentId: '',
        phone: '',
        avatar: '',
      ),
    );

    if (found.id.isNotEmpty) {
      _currentUser = found;
      _isAuthenticated = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _currentUser = null;
    _isAuthenticated = false;
    notifyListeners();
  }
}

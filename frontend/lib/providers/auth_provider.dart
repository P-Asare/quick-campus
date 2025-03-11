import 'package:flutter/material.dart';
import 'package:quickcampus/models/user.dart';
import 'package:quickcampus/services/auth_services.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;
  bool _registrationSuccess = false;
  bool _loginSuccess = false;
  String? _errorMessage;
  bool isLoading = false;

  User? get user => _user;
  bool get registrationSuccess => _registrationSuccess;
  bool get loginSuccess => _loginSuccess;
  String? get errorMessage => _errorMessage;

  // Temporarily store registration details
  Map<String, String> _registrationDetails = {};

  Map<String, String> get registrationDetails => _registrationDetails;

  // Set loading state
  void setLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

// Add new registration details
  void addRegistrationDetails(Map<String, String> details) {
    _registrationDetails.addAll(details);
    notifyListeners(); // Notify listeners about the changes
  }

  // Set registration details
  void setRegistrationDetails(Map<String, String> details) {
    _registrationDetails = details;
    notifyListeners();
  }

  // Clear registration details
  void clearRegistrationDetails() {
    _registrationDetails.clear();
    notifyListeners();
  }

  // User login
  // TODO: Revise lag in log in
  Future<void> login(String email, String password) async {
    setLoading(true);
    try {
      final loginResponse = await _authService.login(email, password);

      print(loginResponse);
      if (loginResponse['success'] == true) {
        _loginSuccess = true;

        // Parse user data from the response
        _user = User.fromJson(loginResponse);
        notifyListeners();
      } else {
        _loginSuccess = false;
        _errorMessage = loginResponse['error'];
      }

      setLoading(false);
    } catch (e) {
      _loginSuccess = false;
      _errorMessage = e.toString();
      setLoading(false);
    }
  }

  // User registration
  Future<void> register() async {
    setLoading(true);
    try {
      final registerResponse = await _authService.register(
        _registrationDetails['firstname']!,
        _registrationDetails['lastname']!,
        _registrationDetails['email']!,
        _registrationDetails['password']!,
        _registrationDetails[
            'password']!, // Assuming confirmPassword is the same for simplicity
        int.parse(_registrationDetails['role']!),
        _registrationDetails['phone_number']!,
      );

      print(registerResponse);

      if (registerResponse['success'] == true) {
        _registrationSuccess = true;
        clearRegistrationDetails(); // Clear registration details after successful registration
      } else {
        _registrationSuccess = false;
        _errorMessage = registerResponse['error'];
      }
      setLoading(false);
    } catch (e) {
      _registrationSuccess = false;
      _errorMessage = e.toString();
      setLoading(false);
    }
  }

  // TODO: Update user information
  void updateUser(User updatedUser) {
    _user = updatedUser;
    notifyListeners();
  }

  // TODO: Get profile
  Future<void> getProfile(int userId) async {
    setLoading(true);
    try {
      final profileResponse = await _authService.getProfile(userId);

      if (profileResponse['success'] == true) {
        _user = User.fromJson(profileResponse);
      } else {
        _errorMessage = profileResponse['error'];
      }

      setLoading(false);
    } catch (e) {
      _errorMessage = e.toString();
      setLoading(false);
    }
  }
}

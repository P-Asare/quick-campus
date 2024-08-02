// splash screen

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:quickcampus/providers/auth_provider.dart';
import 'package:quickcampus/screens/home_page.dart';
import 'package:quickcampus/screens/rider_screens/rider_home_page.dart';
import 'package:quickcampus/widgets/nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'landing_page_one.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final LocalAuthentication auth = LocalAuthentication();

  @override
  void initState() {
    super.initState();

    _checkLoginStatus();

    // delay page switch for 3 seconds
    // Future.delayed(const Duration(seconds: 4), () {
    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(builder: (context) => const FirstLanding()),
    //   );
    // });
  }

  void _navigateToNext() {
    // delay page switch for 3 seconds
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const FirstLanding()),
      );
    });
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final password = prefs.getString('password');
    final biometricEnabled = prefs.getBool('biometricEnabled') ?? false;

    print('Stored email: $email');
    print('Stored password: $password');
    print('Biometric enabled: $biometricEnabled');

    if (email != null && password != null) {
      if (biometricEnabled) {
        print('Attempting biometric authentication...');
        bool authenticated = await _authenticateWithBiometrics();
        if (authenticated) {
          print('Biometric authentication successful');
          _login(email, password);
        } else {
          print('Biometric authentication failed');
          _navigateToNext();
        }
      } else {
        print('Logging in with stored credentials...');
        _login(email, password);
      }
    } else {
      print('No stored credentials found');
      _navigateToNext();
    }
  }

  // Log user into application
  void _login(String email, String password) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.login(email, password);

    if (authProvider.loginSuccess) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const MyNavigationBar()));
    }
  }

  // Authenticate biometrics
  Future<bool> _authenticateWithBiometrics() async {
    try {
      return await auth.authenticate(
        localizedReason: 'Please authenticate to continue',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      print('Error during biometric authentication: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF307A59),
      body: Center(
        child: Image.asset(
          "assets/images/quick-campus-splash.png",
        ),
      ),
    );
  }
}

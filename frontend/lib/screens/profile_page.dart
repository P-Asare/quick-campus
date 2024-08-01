import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickcampus/providers/auth_provider.dart';
import 'package:quickcampus/screens/landing_page_two.dart';
import 'package:quickcampus/widgets/filled_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _imageSelected;

  @override
  void initState() {
    super.initState();
    // Ensure that the provider is initialized and has the necessary data.
  }

  void _logOut(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SecondLanding()));
  }

  void _resetPassword(BuildContext context) {
    // Implementation for resetting the password
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            final user = authProvider.user;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: _imageSelected != null
                          ? FileImage(_imageSelected!)
                          : const AssetImage("assets/images/no_profile.png")
                              as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          color: Color(0xFF307A59),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.edit, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildInfoTile(user?.firstName ?? "Unknown"),
                _buildInfoTile(user?.lastName ?? "Unknown"),
                _buildInfoTile(user?.email ?? "Unknown"),
                _buildResetPasswordTile(context),
                MyFilledButton(
                  title: "Log Out",
                  onPressed: () => _logOut(context),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildInfoTile(String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFD1E2DB),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  Widget _buildResetPasswordTile(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFD1E2DB),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: const Text(
          "Reset Password?",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.arrow_forward_ios_sharp),
          onPressed: () => _resetPassword(context),
        ),
      ),
    );
  }
}

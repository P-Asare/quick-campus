import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:quickcampus/providers/auth_provider.dart';
import 'package:quickcampus/screens/landing_page_two.dart';
import 'package:quickcampus/widgets/filled_button.dart';
import 'dart:convert';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImagePicker _imagePicker = ImagePicker();
  bool _showImageError = false;
  File? _imageSelected;
  bool _biometricEnabled = false;
  final LocalAuthentication auth = LocalAuthentication();
  final userProfileImage =
      'http://16.171.150.101/quick-campus/backend/public/profile_images/';

  @override
  void initState() {
    super.initState();
    _loadProfile();
    // Ensure that the provider is initialized and has the necessary data.
  }

  Future<void> _clearCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('password');
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _biometricEnabled = prefs.getBool('biometricEnabled') ?? false;
    });
  }

  void _logOut(BuildContext context) {
    _clearCredentials();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SecondLanding()));
  }

  void _resetPassword(BuildContext context) {
    // Implementation for resetting the password
  }

  Future<void> selectImageFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );

      if (image != null) {
        setState(() {
          _imageSelected = File(image.path);
          _showImageError = false;
        });

        print(
            "The image path is: ${path.extension(_imageSelected!.path).toLowerCase()}");
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  Future<void> uploadImage(int? userId) async {
    await selectImageFromGallery();

    if (_imageSelected == null) {
      return;
    }

    final imageExtension =
        path.extension(_imageSelected!.path).replaceAll('.', '');
    final mediaType = MediaType('image', imageExtension);

    print("Even closer");

    final uri =
        Uri.parse('http://16.171.150.101/quick-campus/backend/upload/$userId');
    final request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath(
          'profile_image', _imageSelected!.path,
          contentType: mediaType));
    final response = await request.send();
    print("The response is: $response");
    if (response.statusCode == 200) {
      print('Image uploaded successfully');
    } else {
      print("status code: ${response.statusCode}");
    }
  }

  Future<void> _updateBiometricEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('biometricEnabled', value);
    setState(() {
      _biometricEnabled = value;
    });
  }

  Future<void> _authenticateWithBiometrics() async {
    try {
      final bool canCheckBiometrics = await auth.canCheckBiometrics;
      final List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();

      if (canCheckBiometrics && availableBiometrics.isNotEmpty) {
        final bool authenticated = await auth.authenticate(
          localizedReason: 'Please authenticate to enable biometrics',
          options: const AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: true,
          ),
        );
        if (authenticated) {
          _updateBiometricEnabled(true);
        } else {
          setState(() {
            _biometricEnabled = false;
          });
        }
      } else {
        _showBiometricSetupDialog();
        setState(() {
          _biometricEnabled = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        _biometricEnabled = false;
      });
    }
  }

  void _showBiometricSetupDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Biometrics Not Set Up'),
          content: const Text(
              'Biometric authentication is not set up on this device. Please set it up in your device settings.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
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
                          : ((user!.profileImage == null)
                              ? const AssetImage("assets/images/no_profile.png")
                                  as ImageProvider
                              : NetworkImage(
                                  "$userProfileImage/${user.profileImage}")),
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
                          onPressed: () {
                            uploadImage(user!.userId);
                          },
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
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD1E2DB),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SwitchListTile(
                    tileColor: const Color(0xFFD1E2DB),
                    title: const Text('Enable biometric'),
                    value: _biometricEnabled,
                    activeColor: const Color(0xFF307A59),
                    onChanged: (bool value) {
                      if (value) {
                        _authenticateWithBiometrics();
                      } else {
                        _updateBiometricEnabled(value);
                      }
                    },
                  ),
                ),
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

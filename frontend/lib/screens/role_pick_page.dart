import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickcampus/providers/auth_provider.dart';
import 'package:quickcampus/screens/verified_page.dart';
import 'package:quickcampus/widgets/filled_button.dart';

class RolePickPage extends StatefulWidget {
  @override
  _RolePickPageState createState() => _RolePickPageState();
}

class _RolePickPageState extends State<RolePickPage> {
  int? selectedRole;

  void selectRole(int role) {
    setState(() {
      selectedRole = role;
    });
  }

  void goToVerifiedPage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const VerifiedPage()));
  }

  // Submit role and register user
  void submit(BuildContext context) {
    if (selectedRole != null) {
      // Proceed with submission
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.addRegistrationDetails({"role": "$selectedRole"});

      print("Registering about to start: ${authProvider.registrationDetails}");
      // Register user
      authProvider.register();
      // Go to verification page
      goToVerifiedPage(context);
    } else {
      // Show an error message or indication
      print('Please select a role.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'What is your role?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Select the option that describes how you will be contributing to the Quickcampus',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 40),
              RoleButton(
                label: 'Student',
                icon: Icons.school,
                isSelected: selectedRole == 2,
                onTap: () => selectRole(2),
              ),
              const SizedBox(height: 10),
              RoleButton(
                label: 'Rider',
                icon: Icons.motorcycle,
                isSelected: selectedRole == 3,
                onTap: () => selectRole(3),
              ),
              const Spacer(),
              MyFilledButton(
                  title: "Submit",
                  onPressed: () {
                    submit(context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class RoleButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  RoleButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? const Color(0xFF307A59) : Colors.transparent,
          border: Border.all(
            color: isSelected ? const Color(0xFF307A59) : Colors.grey,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.black,
              size: 35,
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

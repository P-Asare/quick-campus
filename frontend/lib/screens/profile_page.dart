// Profile page

import 'package:flutter/material.dart';
import 'package:quickcampus/screens/landing_page_two.dart';
import 'package:quickcampus/widgets/filled_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // Log user out of application
  void _logOut(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SecondLanding()));
  }

  // Forget password
  void _resetPassword(BuildContext context) {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          Stack(
            children: [
              const CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('assets/images/car.png'),
              ),

              // Edit icon
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color(0xFF307A59),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),

          const SizedBox(height: 20),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFD1E2DB),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const ListTile(
              title: Text(
                "Palal",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFD1E2DB),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const ListTile(
              title: Text(
                "Asare",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFD1E2DB),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const ListTile(
              title: Text(
                "johndoe@ashesi.edu.gh",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),

          // password tab
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFD1E2DB),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: const Text(
                "Reset Password?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward_ios_sharp),
                onPressed: () => _resetPassword(context),
              ),
            ),
          ),

          MyFilledButton(title: "Log Out", onPressed: () => _logOut(context))
        ],
      ),
    ));
  }
}

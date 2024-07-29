import 'package:flutter/material.dart';
import 'package:quickcampus/screens/home_page.dart';
import 'package:quickcampus/widgets/filled_button.dart';

class VerifiedPage extends StatelessWidget {
  const VerifiedPage({super.key});

  // route to home page
  void _goToHomePage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(
          20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/confetti_box.png",
            ),

            // spacing
            const SizedBox(height: 30),
            const Text(
              "Congratulations",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
            ),

            // spacing
            const SizedBox(height: 20),

            const Text(
              'Your account has been completed. Go ahead\nand request a delivery.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            // spacing
            const SizedBox(height: 35),

            MyFilledButton(
              title: "Get Started",
              onPressed: () => _goToHomePage(context),
            ),
          ],
        ),
      ),
    );
  }
}

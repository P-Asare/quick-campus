// landing page two

import 'package:flutter/material.dart';
import 'package:quickcampus/screens/sign_in_page.dart';
import 'package:quickcampus/screens/sign_up_page.dart';
import 'package:quickcampus/widgets/filled_button.dart';
import 'package:quickcampus/widgets/transparent_button.dart';

class SecondLanding extends StatelessWidget {
  const SecondLanding({super.key});

  // Route to the sign in page
  void _nextPage(BuildContext context, Widget page) {
    Navigator.of(context).push(_createRoute(page));
  }

  //Animated route
  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 800),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(155, 139, 188, 166), // Green
            Colors.white, // Middle color white
            Colors.white // White
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.1, 0.5, 0.7], // Adjust the percentage of each color
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "QuickCampus",
            style: TextStyle(
              color: Color(0xFF120101),
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w900,
              height: 0,
            ),
          ),

          Image.asset(
            "assets/images/car.png",
          ),

          const Column(
            children: [
              Text(
                "Git pickup from your\ndoorstep",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF120101),
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),

              // Spacing between
              SizedBox(
                height: 20,
              ),

              Text(
                "Request for an item to get delivered\nto any location in Accra",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0x5B120101),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ],
          ),

          // Navaigation Circles
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const ShapeDecoration(
                  color: Color(0xFF307A59),
                  shape: OvalBorder(),
                ),
              ),

              // Spacing
              const SizedBox(
                width: 3,
              ),

              Container(
                width: 8,
                height: 8,
                decoration: const ShapeDecoration(
                  color: Color(0xFFD1E2DB),
                  shape: OvalBorder(),
                ),
              )
            ],
          ),

          // Buttons
          Column(
            children: [
              // Get Started button
              MyFilledButton(
                  title: "Get Started",
                  onPressed: () => _nextPage(context, const SignUpPage())),

              // Space between
              const SizedBox(
                height: 8,
              ),

              // Sign-up button
              MyTransparentButton(
                  title: "Sign In",
                  onPressed: () => _nextPage(context, const SignInPage())),
            ],
          )
        ],
      ),
    ));
  }
}

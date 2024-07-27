import 'package:flutter/material.dart';
import 'package:quickcampus/screens/landing_page_two.dart';
import 'package:quickcampus/widgets/filled_button.dart';
import 'package:quickcampus/widgets/transparent_button.dart';

class FirstLanding extends StatelessWidget {
  const FirstLanding({super.key});

  // Route to the next page
  void _nextPage(BuildContext context) {
    Navigator.of(context).push(_createRoute());
  }

  //Animated route
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const SecondLanding(),
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
            "assets/images/package.png",
          ),

          const Column(
            children: [
              Text(
                "All your\nordered items",
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
                "Purchase an item of your choice and\nhave us deliver it",
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
              // Coninue button
              MyFilledButton(
                  title: "Continue", onPressed: () => _nextPage(context)),

              // Space between
              const SizedBox(
                height: 8,
              ),

              // Sign-up button
              MyTransparentButton(
                title: "Sign In",
                onPressed: () {},
              )
            ],
          )
        ],
      ),
    ));
  }
}

import 'package:flutter/material.dart';

class FirstLanding extends StatelessWidget {
  const FirstLanding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFD1E2DB), // Green
            Colors.white, // Middle color white
            Colors.white // White
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.3, 0.5, 0.7], // Adjust the percentage of each color
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
              Container(
                width: 316,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF307A59),
                    elevation: 0,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7), // Rounded corners
                    ),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Space between
              const SizedBox(
                height: 8,
              ),

              // Sign-up button
              Container(
                width: 316,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD1E2DB),
                    elevation: 0,
                    foregroundColor: const Color(0xFF307A59),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7), // Rounded corners
                    ),
                  ),
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}

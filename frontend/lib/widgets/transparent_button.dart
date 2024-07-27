import 'package:flutter/material.dart';

class MyTransparentButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const MyTransparentButton(
      {super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD1E2DB),
          elevation: 0,
          foregroundColor: const Color(0xFF307A59),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7), // Rounded corners
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

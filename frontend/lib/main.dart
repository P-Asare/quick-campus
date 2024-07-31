import 'package:flutter/material.dart';
import 'package:quickcampus/screens/delivering_page.dart';
import 'package:quickcampus/screens/home_page.dart';
import 'package:quickcampus/screens/landing_page_one.dart';
import 'package:quickcampus/screens/landing_page_two.dart';
import 'package:quickcampus/screens/otp_page.dart';
import 'package:quickcampus/screens/sign_in_page.dart';
import 'package:quickcampus/screens/splash_screen.dart';
import 'package:quickcampus/screens/verified_page.dart';
import 'package:quickcampus/widgets/nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyNavigationBar(),
    );
  }
}

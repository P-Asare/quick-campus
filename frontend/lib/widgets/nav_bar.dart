import 'package:flutter/material.dart';
import 'package:quickcampus/screens/home_page.dart';
import 'package:quickcampus/screens/orders_page.dart';
import 'package:quickcampus/screens/profile_page.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({super.key});

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int currentPage = 0;

  final List<Widget> riderPages = [];

  final List<Widget> pages = [
    const HomePage(),
    const OrdersPage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          border: const Border(
            top: BorderSide(
                // set the top border to green
                color: Color(0xFFD1E2DB),
                width: 2.0),
          ),
        ),
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined, size: 30), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.archive_outlined, size: 30), label: "Orders"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_rounded, size: 30),
                label: "Profile"),
          ],
          currentIndex: currentPage,
          onTap: (index) {
            setState(() {
              currentPage = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          selectedItemColor: const Color(0xFF307A59),
          unselectedItemColor: Colors.grey,
          elevation: 0,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
          showSelectedLabels: true,
          showUnselectedLabels: true,
        ),
      ),
    );
  }
}

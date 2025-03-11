import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickcampus/providers/auth_provider.dart';
import 'package:quickcampus/screens/home_page.dart';
import 'package:quickcampus/screens/orders_page.dart';
import 'package:quickcampus/screens/profile_page.dart';
import 'package:quickcampus/screens/rider_screens/rider_home_page.dart';
import 'package:quickcampus/screens/rider_screens/rider_orders_page.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({super.key});

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int currentPage = 0;

  final List<Widget> riderPages = [
    const RiderHomePage(),
    const RiderOrdersPage(),
    const ProfilePage()
  ];

  final List<Widget> pages = [
    const HomePage(),
    const OrdersPage(),
    const ProfilePage()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    final int userRole = user!.role;

    return Scaffold(
      body: (userRole == 3) ? riderPages[currentPage] : pages[currentPage],
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

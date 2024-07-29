import 'package:flutter/material.dart';
import 'package:quickcampus/screens/sending_page.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 12,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        bottom: TabBar(
          labelColor: Colors.black,
          indicatorColor: const Color(0xFF307A59),
          labelStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelStyle: const TextStyle(
              color: Color.fromARGB(118, 158, 158, 158),
              fontWeight: FontWeight.w500),
          controller: _tabController,
          tabs: const [
            // sending tab
            Tab(text: 'Sending'),

            // deliverigng tab
            Tab(text: 'Delivering'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          SendingPage(),
          Center(
            child: Text("other"),
          )
        ],
      ),
    );
  }
}



import 'package:flutter/material.dart';
import 'package:quickcampus/screens/sending_page.dart';
import 'package:quickcampus/widgets/rider_request_tile.dart';

class RiderHomePage extends StatefulWidget {
  const RiderHomePage({super.key});

  @override
  State<RiderHomePage> createState() => _RiderHomePageState();
}

class _RiderHomePageState extends State<RiderHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 12,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RiderRequestTile(
              from: "West hills mall",
              fromAddress: "new road Ave.",
              to: "Ashesi University",
              toAddress: "1 University Ave",
            ),
            RiderRequestTile(
              from: "West hills mall",
              fromAddress: "new road Ave.",
              to: "Ashesi University",
              toAddress: "1 University Ave",
            )
          ],
        ),
      ),
    );
  }
}

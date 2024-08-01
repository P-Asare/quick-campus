import 'package:flutter/material.dart';
import 'package:quickcampus/widgets/rider_order_tile.dart';

class RiderOrdersPage extends StatefulWidget {
  const RiderOrdersPage({super.key});

  @override
  State<RiderOrdersPage> createState() => _RiderOrdersPageState();
}

class _RiderOrdersPageState extends State<RiderOrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: true,
        title: const Text(
          "Requests",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize:
              const Size.fromHeight(1.0), // Sets the height of the border
          child: Container(
            color: const Color(0xFFD1E2DB), // Sets the color of the border
            height: 1.0, // Sets the thickness of the border
          ),
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              RiderOrderTile(
                from: "West hills mall",
                fromAddress: "new road Ave.",
                to: "Ashesi University",
                toAddress: "1 University Ave",
                student: "Palal",
                date: "2022-May-27",
              ),

              // spacing
              SizedBox(
                height: 15,
              ),

              RiderOrderTile(
                from: "West hills mall",
                fromAddress: "new road Ave.",
                to: "Ashesi University",
                toAddress: "1 University Ave",
                student: "Palal",
                date: "2022-May-27",
              ),

              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:quickcampus/widgets/rider_request_tile.dart';

class RiderHomePage extends StatefulWidget {
  const RiderHomePage({super.key});

  @override
  State<RiderHomePage> createState() => _RiderHomePageState();
}

class _RiderHomePageState extends State<RiderHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: true,
        title: const Text(
          "Home",
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
              RiderRequestTile(
                from: "West hills mall",
                fromAddress: "new road Ave.",
                to: "Ashesi University",
                toAddress: "1 University Ave",
              ),

              // spacing
              SizedBox(
                height: 15,
              ),

              RiderRequestTile(
                from: "West hills mall",
                fromAddress: "new road Ave.",
                to: "Ashesi University",
                toAddress: "1 University Ave",
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

import 'package:flutter/material.dart';
import 'package:quickcampus/widgets/order_tile.dart';

class SendingPage extends StatelessWidget {
  const SendingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          children: [
            // spacing
            SizedBox(
              height: 10,
            ),

            OrderTile(
              from: "West hills mall",
              fromAddress: "new road Ave.",
              to: "Ashesi University",
              toAddress: "1 University Ave",
              driver: "Jimmy Doer",
              rating: 4.5,
              onGoing: true,
              date: "2022 Mar, 15",
            ),

            // spacing
            SizedBox(
              height: 10,
            ),

            OrderTile(
              from: "West hills mall",
              fromAddress: "new road Ave.",
              to: "Ashesi University",
              toAddress: "1 University Ave",
              driver: "Jimmy Doer",
              rating: 4.5,
              onGoing: true,
              date: "2022 Mar, 15",
            ),

            // spacing
            SizedBox(
              height: 10,
            ),

            OrderTile(
              from: "West hills mall",
              fromAddress: "new road Ave.",
              to: "Ashesi University",
              toAddress: "1 University Ave",
              driver: "Jimmy Doer",
              rating: 4.5,
              onGoing: true,
              date: "2022 Mar, 15",
            ),

            // spacing
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

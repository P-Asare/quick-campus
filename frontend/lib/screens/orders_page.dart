import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sending'),
      ),
      body: const SingleChildScrollView(
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
      ),
    );
  }
}

class OrderTile extends StatelessWidget {
  final String date;
  final String from;
  final String fromAddress;
  final String to;
  final String toAddress;
  final String driver;
  final double rating;
  final bool onGoing;

  const OrderTile({
    super.key,
    required this.date,
    required this.from,
    required this.fromAddress,
    required this.to,
    required this.toAddress,
    required this.driver,
    required this.rating,
    required this.onGoing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 295,
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF307A59),
          width: 2.0,
        ),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status Container (Arrived or Moving)
              Container(
                padding: const EdgeInsets.only(
                  top: 8,
                  left: 12,
                  right: 12,
                  bottom: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF307A59),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(onGoing ? "Moving" : "Arrived",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        )),
                    const SizedBox(width: 4),
                    Icon(
                      onGoing ? Icons.pedal_bike : Icons.check,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),

              // spacing
              const SizedBox(height: 15),

              // From and To Columns
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // From
                    Text(
                      from,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      fromAddress,
                      style: const TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 20),

                    // To
                    Text(to,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        )),
                    const SizedBox(height: 5),
                    Text(
                      toAddress,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Driver profile
              ListTile(
                leading: const CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage("assets/images/car.png"),
                ),
                title: Text(
                  driver,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Row(
                  children: [
                    Text("$rating"),
                    const SizedBox(width: 4),
                    const Icon(Icons.star,
                        color: Color.fromARGB(141, 255, 193, 7)),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Ongoing or done
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    onGoing
                        ? "This delivery is ongoing"
                        : "This delivery was successfully completed",
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ],
              )
            ],
          ),
          Positioned(
            top: 12,
            right: 16,
            child: Text(
              date,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          Positioned(
            top: 80,
            right: 10,
            child: Image.asset(
              'assets/images/boxes.png', // Replace with your actual image path
              width: 120,
            ),
          ),
          Positioned(
            left: -50,
            top: -225, // Vertically center the image
            child: Image.asset(
              'assets/images/location-path.png', // Replace with your actual image path
              width: 120,
            ),
          ),
        ],
      ),
    );
  }
}

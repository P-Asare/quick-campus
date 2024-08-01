import 'package:flutter/material.dart';

class RiderOrderTile extends StatelessWidget {
  final String date;
  final String from;
  final String fromAddress;
  final String to;
  final String toAddress;
  final String student;

  const RiderOrderTile({
    super.key,
    required this.date,
    required this.from,
    required this.fromAddress,
    required this.to,
    required this.toAddress,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 205,
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
                  student,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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
            top: 40,
            right: 10,
            child: Image.asset(
              'assets/images/boxes.png', // Replace with your actual image path
              width: 120,
            ),
          ),
          Positioned(
            left: -50,
            top: -285, // Vertically center the image
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

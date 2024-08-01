import 'package:flutter/material.dart';

class RiderRequestTile extends StatelessWidget {
  final String from;
  final String fromAddress;
  final String to;
  final String toAddress;

  const RiderRequestTile({
    super.key,
    required this.from,
    required this.fromAddress,
    required this.to,
    required this.toAddress,
  });

  // function to accept a request
  void _acceptRequest(){

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: double.infinity,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
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
                    GestureDetector(
                      onTap: () => _acceptRequest(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: const Color(0xFF307A59),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Row(
                          children: [
                            Text(
                              "Accept",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
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

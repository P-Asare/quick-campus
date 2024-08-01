import 'package:flutter/material.dart';


class DeliveryStatus extends StatelessWidget {
  final String status;
  final String enabler;
  final String timeStamp;
  final bool complete;

  const DeliveryStatus({
    super.key,
    required this.status,
    required this.enabler,
    required this.timeStamp,
    required this.complete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.circle,
        size: 20,
        color: complete ? Colors.green : Colors.black,
      ),
      title: Text(
        status,
        style: TextStyle(
            fontSize: 16,
            fontWeight: complete ? FontWeight.w400 : FontWeight.bold),
      ),
      subtitle: Text(
        enabler,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 13,
        ),
      ),
      trailing: Text(
        timeStamp,
        style: TextStyle(
          fontSize: 14,
          fontWeight: complete ? FontWeight.w300 : FontWeight.bold,
        ),
      ),
    );
  }
}

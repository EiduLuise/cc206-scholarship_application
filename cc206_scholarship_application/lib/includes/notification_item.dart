import 'package:flutter/material.dart';

// Class that returns a card inside listview builder for notifications page
class NotificationItem extends StatelessWidget {
  final String name;
  final String deadline;

  const NotificationItem({
    required this.name,
    required this.deadline,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: ListTile(
            leading: const Icon(Icons.notifications, color: Color(0xFF234469), size: 40),
            title: Text(
              name,
              style: const TextStyle(fontSize: 16),
            ),
            subtitle: Text(
              'Deadline: $deadline',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            trailing: const Icon(Icons.circle, size: 16, color: Colors.red),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          ),
        ),
      ),
    );
  }
}

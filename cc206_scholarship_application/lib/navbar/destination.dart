import 'package:flutter/material.dart';

// Destination labels for bottom navbar
class Destination {
  const Destination({required this.label, required this.icon});

  final String label;
  final IconData icon;
}

const destinations = [
  Destination(label: 'Calendar', icon: Icons.calendar_today),
  Destination(label: 'Notifications', icon: Icons.notifications),
  Destination(label: 'Home', icon: Icons.home),
  Destination(label: 'My Scholarships', icon: Icons.school),
  Destination(label: 'Profile', icon: Icons.person),
];
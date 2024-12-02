import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Scaffold for pages and bottom navigation bar
// Makes bottom navigation bar prominent no matter what page your are on
class LayoutScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final ValueChanged<int>? onItemTapped;

  const LayoutScaffold({
    required this.navigationShell,
    this.onItemTapped,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          onItemTapped?.call(index);
          navigationShell.goBranch(index);
        },
        backgroundColor: Colors.white, // Set background color to gray
        selectedItemColor: Colors.deepOrange, // Active page indicator color
        unselectedItemColor: const Color(0xFF234469), // Unselected icon/text color
        type: BottomNavigationBarType.fixed, // Keeps button size consistent
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'My Application'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

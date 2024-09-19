import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:cc206_scholarship_application/features/log_in_page.dart';

void main() {
  runApp(const LogInPage());
}

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Widgets for LogInPage
          Icon(
            Icons.person,
            color: Colors.red,
            size: 200,
          ),

          Text(
            'Log In',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          // Name TextFormField
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Email',
            ),
          ),   

          // Password TextFormField
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Password',
            ),
            obscureText: true,
          ),
          
        ],
      ),
    );
  }
}

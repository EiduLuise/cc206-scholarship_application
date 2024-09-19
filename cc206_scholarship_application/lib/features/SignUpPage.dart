import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
           Icon(
            Icons.person,
            color: Colors.blue,
            size: 200,
          ),

          Text(
            'Sign Up',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
         
          // FIrst Name TextFormField
          TextFormField(
            decoration: InputDecoration(
              labelText: 'First Name',
            ),
          ),
         
         // Last Name TextFormField
         TextFormField(
            decoration: InputDecoration(
              labelText: 'Last Name',
            ),
          ),

          // Email TextFormField
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
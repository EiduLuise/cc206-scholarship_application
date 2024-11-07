import 'package:flutter/material.dart';

import '../features/log_in_page.dart';

final _formKey = GlobalKey<FormState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Email validation function
  String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,}(\.\w{2,})?$');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (!isEmailValid) {
      return 'Please enter a valid email';
    }
    return null;
  }

   String? validatePhoneNumber(String? phoneNumber) {
    RegExp phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');
    final isPhoneValid = phoneRegex.hasMatch(phoneNumber ?? '');
    if (!isPhoneValid) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 60.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Create New Account',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
               
                Image.asset('assets/images/scholarship.png',
                  height: 300,),
                const SizedBox(height: 20),
            
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                      prefixIcon: const Icon(Icons.person),
                      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
            
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: const Icon(Icons.email),
                      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    validator: validateEmail,
                  ),
                ),
                const SizedBox(height: 20),
            
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Phone number',
                      prefixIcon: const Icon(Icons.phone),
                      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    validator: validatePhoneNumber,
                  ),
                ),
                const SizedBox(height: 20),
            
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
               
                const SizedBox(height:5),
               
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      _formKey.currentState!.validate();
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          actions: [
                            TextButton(
                                onPressed: () {
                                   Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const LogIn()),
                                  );
                                },
                                child: const Text('Continue')),
                          ],
                          title: const Text('GrantEd'),
                          contentPadding: const EdgeInsets.all(20.0),
                          content: const Text('Press Continue to Login'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Color(0xFF234469),
                    ),
                    child: const Center(
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
            
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(color: Color(0xFF234469)),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LogIn()),
                        );
                      },
                      child: const Text(
                        "Log In",
                        style: TextStyle(
                          color: Colors.deepOrange,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';


void main() {
  runApp(const LogInPage());
}


class LogInPage extends StatelessWidget {
  const LogInPage({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Log In Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignUpPage(),
    );
  }
}


class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 60.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Sign Up text
              const Text(
                'Log In',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Placeholder for Image

                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.blue,
                      child: CircleAvatar(
                        radius: 50,
                      child: Icon(Icons.person, size: 70, color: Colors.blue,),
                      ),
                    ),
                  ],
                ),

              const SizedBox(height: 40),


              // Email input field
              SizedBox(
                width: 300, // Adjust width as needed
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Your Email',
                    prefixIcon: const Icon(Icons.email),
                    contentPadding: const EdgeInsets.symmetric(vertical: 8.0), // Adjust height
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
              ),
              const SizedBox(height: 20),


              // Password input field
              SizedBox(
                width: 300, // Adjust width as needed
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    contentPadding: const EdgeInsets.symmetric(vertical: 8.0), // Adjust height
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


              // Sign Up button with same width as the text fields
              SizedBox(
                width: 300, // Adjust width as needed
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                  child: const Center(
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),


              // Already have an account? Log in
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      // Navigate to Log in page
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.blue,
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
    );
  }
}




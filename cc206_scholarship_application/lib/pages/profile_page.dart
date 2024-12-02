import 'package:cc206_scholarship_application/database/userScholarship.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = 'Loading...';
  String email = 'Loading...';
  String aboutText =
      "Jung Mo-eum is a childhood friend of Seok-ryu and Seung-hyo, having grown up alongside them in the neighborhood of Hyeryeong. As such, Mo-eum knows all the secrets...";

  // Fetch and display user details (name and email)
  void fetchAndDisplayUserDetails() async {
    UserScholarship userScholarship = UserScholarship();
    Map<String, dynamic>? userDetails = await userScholarship.getUserDetails();

    if (userDetails != null) {
      setState(() {
        name = userDetails['name'] ?? 'No name available';
        email = userDetails['email'] ?? 'No email available';
      });
    } else {
      print("Failed to fetch user details");
    }
  }

  // Method to edit the "About" section
  void editAbout() {
    TextEditingController controller = TextEditingController(text: aboutText);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit About'),
          content: TextField(
            controller: controller,
            maxLines: 5,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  aboutText = controller.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // Fetch user details when the page loads
    fetchAndDisplayUserDetails(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color(0xFF234469),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // User Avatar and QR Code Row
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_back_ios, size: 20),
                  Icon(Icons.qr_code, size: 50),
                ],
              ),
              const SizedBox(height: 20),

              // User Info Section
              Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    name, // Display user's name
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    email, // Display user's email
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // About Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "About",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            aboutText, // Display the dynamic aboutText
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, size: 16),
                          onPressed: editAbout,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Personal Details Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Personal Details',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text('Age: 21'),
                          Text('Birthday: October 9, 2003'),
                          Text('Hobbies: Read Comics, Watch Drama'),
                          Text('Goals: Graduate'),
                        ],
                      ),
                    ),
                    Icon(Icons.edit, size: 16),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Interests Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Interests',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Chip(
                          label: Text('ICT'),
                          backgroundColor: Color(0xFF234469),
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 5),
                        Chip(
                          label: Text('Medicine'),
                          backgroundColor: Color(0xFF234469),
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 5),
                        Chip(
                          label: Text('Education'),
                          backgroundColor: Color(0xFF234469),
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Icon(Icons.edit, size: 16),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Wallet Title
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Wallet",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Wallet Balance Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFF234469),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '₱11,489.90',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 50),

              // Logout Button at the Bottom
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      // Sign out the user from firebase
                      await FirebaseAuth.instance.signOut();

                      // Navigate to the login page and clear the navigation stack
                      if (context.mounted) {
                        GoRouter.of(context).go('/login');
                      }
                    } catch (e) {
                      print('Error signing out: $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to log out: $e')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                  ),
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

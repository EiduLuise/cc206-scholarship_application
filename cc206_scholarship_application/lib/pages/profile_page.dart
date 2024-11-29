import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
 
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // User Avatar and QR Code Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.arrow_back_ios, size: 20),
                const Icon(Icons.qr_code, size: 50),
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
                const Text(
                  'Jung Mo Eum',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  '@Jung Mo Eum',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // About Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Expanded(
                    child: Text(
                      "About\nJung Mo-eum is a childhood friend of Seok-ryu and Seung-hyo, having grown up alongside them in the neighborhood of Hyeryeong. Has such, Mo-eum knows all the secrets...",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(Icons.edit, size: 16),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Personal Details Section
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
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
                  const Icon(Icons.edit, size: 16),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Interests',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: const [
                      Chip(label: Text('ICT')),
                      SizedBox(width: 5),
                      Chip(label: Text('Medicine')),
                      SizedBox(width: 5),
                      Chip(label: Text('Education')),
                    ],
                  ),
                  const Icon(Icons.edit, size: 16),
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
                color: const Color(0xFFFF8A65),
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
          ],
        ),
      ),
    );
  }
}

import 'package:cc206_scholarship_application/database/userScholarship.dart';
import 'package:flutter/material.dart';
import '../database/scholarship.dart';
import 'scholarship_detail_page.dart';  // Make sure this import is correct

// Class that creates a card when it is called inside a listview builder inside my home page
class ScholarshipCard extends StatelessWidget {
  final Scholarship scholarship;
  final UserScholarship _userScholarship = UserScholarship();

  ScholarshipCard({super.key, required this.scholarship});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        color: Colors.white,
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Scholarship name
              Text(
                scholarship.scholarshipName,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF234469),
                ),
              ),
              const SizedBox(height: 8),

              //Scholarship category on right side
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(), 
                  Text(
                    'Category: ${scholarship.scholarshipCategory}',
                     style: const TextStyle(fontSize: 14),
                 ),
                ],
              ),
              const SizedBox(height: 8),

              //Scholarship deadline on right side
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(), 
                  Text(
                    'Deadline: ${scholarship.scholarshipDeadline}',
                    style: const TextStyle(color: Colors.deepOrange, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Apply button
              ElevatedButton(
                onPressed: () {
                  // Go to pa page with further details about a specific scholarship
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScholarshipDetailPage(
                        scholarship: scholarship,
                      ),
                    ),
                  );

                  // add scholarship ID to array inside users table
                  // when the users applied for a scholarship, the name and eadline of scholarship will go to notifications
                  _userScholarship.addScholarshipId(scholarship.scholarshipId);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: const Color(0xFF234469),
                ),
                child: const Text(
                  'Apply Now',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:cc206_scholarship_application/database/userScholarship.dart';
import 'package:flutter/material.dart';
import '../database/scholarship.dart';

// Class that creates a card when it is called inside a listview builder inside my applied scholarships page
class MyScholarshipCard extends StatelessWidget {
  final Scholarship scholarship;

  MyScholarshipCard({super.key, required this.scholarship});

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

              // Scholarship deadline on right side
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

              // Application status of user (static)
              ElevatedButton(
                onPressed: () {
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.deepOrange,
                ),
                child: const Text(
                  'Application Status: PENDING',
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
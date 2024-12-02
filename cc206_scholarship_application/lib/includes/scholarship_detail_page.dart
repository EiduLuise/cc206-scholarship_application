import 'package:flutter/material.dart';
import '../database/scholarship.dart';

// Class that displays further details about scholarship
class ScholarshipDetailPage extends StatelessWidget {
  final Scholarship scholarship;

  const ScholarshipDetailPage({super.key, required this.scholarship});

  @override
  Widget build(BuildContext context) {
    List<String> requirements = scholarship.scholarshipRequirements;

    return Scaffold(
      appBar: AppBar(
        // Scholarship name on appbar
        title: Text(
          scholarship.scholarshipName,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        backgroundColor: const Color(0xFF234469),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Scholarship description
            Text(
              scholarship.scholarshipDescription,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),

            // Scholarship category
            Text(
              'Category: ${scholarship.scholarshipCategory}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),

            // Scholarship deadline
            Text(
              'Deadline: ${scholarship.scholarshipDeadline}',
              style: const TextStyle(color: Colors.deepOrange, fontSize: 16),
            ),
            const SizedBox(height: 16),

            // Scholarship requirements
            const Text(
              'Requirements:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            // converts array from API into list to display vertically
            const SizedBox(height: 8),
            ...requirements.map(
              (requirement) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '- ',
                      style: TextStyle(fontSize: 16),
                    ),
                    Expanded(
                      child: Text(
                        requirement.trim(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Submit application button (static)
            ElevatedButton(
              onPressed: () {
                print('User applying for: ${scholarship.scholarshipId}');
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: const Color(0xFF234469),
              ),
              child: const Text(
                'Submit Application',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

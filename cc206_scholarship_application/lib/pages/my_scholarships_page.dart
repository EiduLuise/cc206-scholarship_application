import 'package:cc206_scholarship_application/database/fetchAllScholarship.dart';
import 'package:cc206_scholarship_application/database/userScholarship.dart';
import 'package:cc206_scholarship_application/database/scholarship.dart';
import 'package:cc206_scholarship_application/includes/my_scholarship_card.dart';
import 'package:flutter/material.dart';

class MyScholarshipPage extends StatefulWidget {
  const MyScholarshipPage({super.key});

  @override
  State<MyScholarshipPage> createState() => MyScholarshipsPageState();
}

// When the user presses the 'Apply Now' button, the details of the scholarship will transfer to the my scholarships page
// Details such as deadline will go to notifications page and calendar page
class MyScholarshipsPageState extends State<MyScholarshipPage> { 
  // Fetch scholarship name and deadline according to what scholarshuos the user has applied for
  final UserScholarship _userScholarship = UserScholarship();
  final fetchAllScholarships _fetchAllScholarships = fetchAllScholarships();

  // Creates a list for notification and scholarship IDs
  List<int> scholarshipIds = [];
  List<Scholarship?> scholarships = [];
  bool _isLoading = true;

// Refesh page
  Future<void> refreshPage() async {
    setState(() {
      _isLoading = true;
    });
    await _loadScholarshipData();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadScholarshipData();
  }

  // Load new uodated data fetched from firestore
  Future<void> _loadScholarshipData() async {
    try {
      scholarshipIds = await _userScholarship.fetchScholarshipId();
      scholarships = await Future.wait(
        scholarshipIds.map((id) => _fetchAllScholarships.fetchElementById(id)),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading scholarship data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Scholarships',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color(0xFF234469),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : scholarships.isEmpty
              ? const Center(child: Text('No scholarships found'))
              : ListView.builder(
                  itemCount: scholarships.length,
                  itemBuilder: (context, index) {
                    final scholarship = scholarships[index];
                    // scholarship card tp display details of scholarship
                    return MyScholarshipCard(scholarship: scholarship!);
                  },
                ),
    );
  }
}

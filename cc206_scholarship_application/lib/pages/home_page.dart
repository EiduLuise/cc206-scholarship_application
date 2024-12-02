import 'package:flutter/material.dart';
import '../database/fetchAllScholarship.dart';
import '../includes/scholarship_card.dart';
import '../database/scholarship.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final fetchAllScholarships _fetchAllScholarships = fetchAllScholarships();
  List<Scholarship> scholarships = [];
  List<Scholarship> filteredScholarships = [];
  bool isLoading = true;
  String errorMessage = '';
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchScholarships();
  }

  // Fetch all scholarships from API
  Future<void> _fetchScholarships() async {
    try {
      final data = await _fetchAllScholarships.fetchScholarships();
      setState(() {
        scholarships = data;
        filteredScholarships = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load scholarships. Please try again later.';
      });
      print('Error: $e');
    }
  }

  // Filter scholarships according to searchbar
  void _filterScholarships(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        filteredScholarships = scholarships;
      } else {
        filteredScholarships = scholarships
            .where((scholarship) =>
                scholarship.scholarshipName.toLowerCase().contains(query.toLowerCase()) ||
                scholarship.scholarshipDescription.toLowerCase().contains(query.toLowerCase()) ||
                scholarship.scholarshipCategory.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
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
      body: Column(
        children: [
          // Searchbar
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              onChanged: _filterScholarships,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search scholarships...',
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: const BorderSide(color: Color(0xFF234469)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: const BorderSide(color: Color(0xFF234469)),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              ),
            ),
          ),
          // Display all scholarships in a card with details (scholarship_card.dart)
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : errorMessage.isNotEmpty
                    ? Center(child: Text(errorMessage))
                    : filteredScholarships.isEmpty
                        ? const Center(child: Text('No scholarships available'))
                        : ListView.builder(
                            itemCount: filteredScholarships.length,
                            itemBuilder: (context, index) {
                              final scholarship = filteredScholarships[index];
                              return ScholarshipCard(scholarship: scholarship);
                            },
                          ),
          ),
        ],
      ),
    );
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'scholarship.dart';


class fetchAllScholarships {
  // Make base URL for API
  static const String baseUrl = "https://dummyjson.com/c/4fc9-bb3e-4aee-bee9";

  // Fetch all scholarships from the API
  Future<List<Scholarship>> fetchScholarships() async {
    final response = await http.get(Uri.parse(baseUrl));

    // Wait for API repsponse in json format
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List scholarshipsJson = jsonResponse['scholarship'];
      return scholarshipsJson.map((data) => Scholarship.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load scholarships');
    }
  }

  // Fetch an element from API according to ID
  Future<Scholarship?> fetchElementById(int id) async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<dynamic> data = jsonResponse['scholarship'];

        // Check if the data is not empty and return null if ID is not found
        if (data.isNotEmpty) {
          var scholarshipJson = data.firstWhere(
            (item) => item['scholarship_id'] == id, 
            orElse: () => null, 
          );

          // Return if data is not null
          if (scholarshipJson != null) {
            return Scholarship.fromJson(scholarshipJson); 
          } else {
            print('No matching scholarship found for ID: $id');
            return null;
          }
        } else {
          print('No scholarships available in the response.');
          return null;
        }
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching element by ID: $e');
      return null;
    }
  }

}

class Scholarship {
  final int scholarshipId;
  final String scholarshipName;
  final String scholarshipDescription;
  final List<String> scholarshipRequirements;
  final String scholarshipDeadline;
  final String scholarshipCategory;

  Scholarship({
    required this.scholarshipId,
    required this.scholarshipName,
    required this.scholarshipDescription,
    required this.scholarshipRequirements,
    required this.scholarshipDeadline,
    required this.scholarshipCategory,
  });

  // Json format into dynamic array
  factory Scholarship.fromJson(Map<String, dynamic> json) {
    return Scholarship(
      scholarshipId: json['scholarship_id'],
      scholarshipName: json['scholarship_name'],
      scholarshipDescription: json['scholarship_description'],
      scholarshipRequirements: List<String>.from(json['scholarship_requirements']),
      scholarshipDeadline: json['scholarship_deadline'],
      scholarshipCategory: json['scholarship_category'],
    );
  }
}

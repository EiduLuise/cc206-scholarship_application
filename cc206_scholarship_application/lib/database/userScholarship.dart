import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserScholarship {

  
  // Add scholarship IDs to an array filed in users table 
  Future<void> addScholarshipIdToFirestore(int scholarshipId) async {
    try {
      // Get current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Insert to users table
        DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);
        
        // Add scholarship ID array inside users table
        await userDoc.update({
          'ScholarshipId': FieldValue.arrayUnion([scholarshipId]),
          'NotificationId': FieldValue.arrayUnion([scholarshipId]),
        });

        print("Scholarship ID added successfully");
      } else {
        print("No user is signed in");
      }
    } catch (e) {
      print("Error adding Scholarship ID: $e");
    }
  }

  // Fetch scholarship ID array from users table
  void addScholarshipId(int scholarshipId) {
    addScholarshipIdToFirestore(scholarshipId);
  }

  // Fetch scholarship Ids and put it in list
  Future<List<int>> fetchScholarshipId() async {
    try {
      // Get current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Get user from users table
        DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);
        DocumentSnapshot docSnapshot = await userDoc.get();

        if (docSnapshot.exists) {
          // Put scholarship Ids in list
          List<dynamic> scholarshipId = docSnapshot['ScholarshipId'] ?? [];
          return scholarshipId.cast<int>();
        } else {
          print('User document does not exist');
          return [];
        }
      } else {
        print('No user is signed in');
        return [];
      }
    } catch (e) {
      print('Error fetching scholarship IDs: $e');
      return [];
    }
  }

  // Notification ID is the same as scholarship ID
  Future<List<int>> fetchNotificationId() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);
        DocumentSnapshot docSnapshot = await userDoc.get();

        if (docSnapshot.exists) {
          List<dynamic> scholarshipId = docSnapshot['NotificationId'] ?? [];
          return scholarshipId.cast<int>(); // Convert to List<int>
        } else {
          print('User document does not exist');
          return [];
        }
      } else {
        print('No user is signed in');
        return [];
      }
    } catch (e) {
      print('Error fetching scholarship IDs: $e');
      return [];
    }
  }

  // Remove a notification according to ID and it soed not affect the scholarship ID array
  Future<void> removeNotificationById(int notificationId) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);
        DocumentSnapshot docSnapshot = await userDoc.get();

        if (docSnapshot.exists) {
          List<dynamic> scholarshipIds = docSnapshot['NotificationId'] ?? [];
          scholarshipIds.remove(notificationId);

          // Update the Firestore document
          await userDoc.update({
            'NotificationId': scholarshipIds,
          });

          print('Notification removed from Firestore');
        } else {
          print('User document does not exist');
        }
      } else {
        print('No user is signed in');
      }
    } catch (e) {
      print('Error removing notification: $e');
    }
  }

  // Get user details for profile page
  Future<Map<String, dynamic>?> getUserDetails() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);
        DocumentSnapshot docSnapshot = await userDoc.get();

        if (docSnapshot.exists) {
          // Returning user details as a Map
          return docSnapshot.data() as Map<String, dynamic>;
        } else {
          print('User document does not exist');
          return null;
        }
      } else {
        print('No user is signed in');
        return null;
      }
    } catch (e) {
      print('Error fetching user details: $e');
      return null;
    }
  }
}
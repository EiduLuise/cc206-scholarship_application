import 'package:cc206_scholarship_application/database/fetchAllScholarship.dart';
import 'package:cc206_scholarship_application/database/scholarship.dart';
import 'package:cc206_scholarship_application/database/userScholarship.dart';
import 'package:cc206_scholarship_application/includes/notification_item.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => NotificationsPageState();
}

// Content of notifications age and calendar page depend if what scholarship the user has applied for
class NotificationsPageState extends State<NotificationsPage> {
  // Fetch scholarship name and deadline according to what scholarshuos the user has applied for
  final UserScholarship _userScholarship = UserScholarship();
  final fetchAllScholarships _fetchAllScholarships = fetchAllScholarships();

  // Creates a list for notification and scholarship IDs
  List<int> notificationIds = [];
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
      notificationIds = await _userScholarship.fetchNotificationId();
      scholarships = await Future.wait(
        notificationIds.map((id) => _fetchAllScholarships.fetchElementById(id)),
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
          'Notifications',
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
          : notificationIds.isEmpty
              ? const Center(child: Text('No more notifications'))
              : Column(
                  children: [
                    Expanded(
                      child: notificationIds.isNotEmpty
                          ? ListView.builder(
                              itemCount: notificationIds.length,
                              itemBuilder: (context, index) {
                                final scholarship = scholarships[index];
                                return Dismissible(
                                  key: Key(notificationIds[index].toString()),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (direction) {
                                    // Get the notificationId to be passed to removeNotificationById method
                                    int notificationId = notificationIds[index];

                                    // Remove the item from both lists and update the UI
                                    setState(() {
                                      // Remove the scholarship at the given index
                                      scholarships.removeAt(index);  
                                      // Remove the notificationId at the given index
                                      notificationIds.removeAt(index);
                                    });

                                    // Call the method to remove the notification by its ID in Firestore
                                    _userScholarship.removeNotificationById(notificationId);

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Notification deleted'),
                                      ),
                                    );
                                  },
                                  background: Container(
                                    color: Colors.red,
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 2.0,
                                    child: NotificationItem(
                                      name: scholarship?.scholarshipName ?? 'No Name',
                                      deadline: scholarship?.scholarshipDeadline ?? 'No Deadline',
                                    ),
                                  ),
                                );

                              },
                            )
                          : const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  'No more notifications',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
    );
  }
}
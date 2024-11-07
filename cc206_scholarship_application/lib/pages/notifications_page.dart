import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notifications Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NotificationsPage(),
    );
  }
}

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<String> notifications = [
    'Application Confirmed',
    'Application Submitted',
    'Application Pending',
    'Application Denied',
    'Submission Due in 2 months',
    'Submission Due in 3 Weeks',
    'Submission Due in 5 Days',
    'Submission Due Tomorrow',
    'Submission Overdue',
  ];

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

      body: Column(
        children: [
          Expanded(
            child: notifications.isNotEmpty
                ? ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key(notifications[index]),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          setState(() {
                            notifications.removeAt(index);
                          });

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
                        child: NotificationItem(notifications[index]),
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, color: Colors.grey),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, color: Colors.deepOrange),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.grey),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school, color: Colors.grey),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.grey),
            label: '',
          ),
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String title;

  const NotificationItem(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: ListTile(
            leading: const Icon(Icons.notifications, color: Color(0xFF234469), size: 40),
            title: Text(title, style: const TextStyle(fontSize: 16)),
            trailing: const Icon(Icons.circle, size: 16, color: Colors.red),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          ),
        ),
      ),
    );
  }


}
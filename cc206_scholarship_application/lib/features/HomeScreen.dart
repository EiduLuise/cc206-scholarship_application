import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scholarship App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextField(
          decoration: InputDecoration(
            hintText: 'Search for Scholarship',
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),
      body: Column(
        children: [
          // Filter Row
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: const Text('Filters',
                  style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('All',
                  style: TextStyle(color: Color(0xFF234469)),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Category',
                  style: TextStyle(color: Color(0xFF234469)),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 7,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'DOST SCHOLARSHIP PROGRAMME\n2023 - 2024',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Deadline: 16 September 2023',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 50),
                              backgroundColor: Color(0xFF234469),
                            ),
                            child: const Text('Apply Now',
                            style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today, color: Colors.grey),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications, color: Colors.grey),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.orange),
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
        ],
      ),
    );
  }
}

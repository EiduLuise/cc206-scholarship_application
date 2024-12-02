import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cc206_scholarship_application/database/fetchAllScholarship.dart';
import 'package:cc206_scholarship_application/database/scholarship.dart';
import 'package:cc206_scholarship_application/database/userScholarship.dart';

class Events {
  final String title;
  Events(this.title);

  @override
  String toString() {
    return title;
  }
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<Events>> events = {};
  TextEditingController _eventController = TextEditingController();
  late final ValueNotifier<List<Events>> _selectedEvents;

  final UserScholarship _userScholarship = UserScholarship();
  final fetchAllScholarships _fetchAllScholarships = fetchAllScholarships();

  List<int> notificationIds = [];
  List<Scholarship?> scholarships = [];
  bool _isLoading = true;

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
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

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
  void dispose() {
    _eventController.dispose(); // Properly dispose the controller
    _selectedEvents.dispose(); // Dispose the ValueNotifier
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      _selectedEvents.value = _getEventsForDay(selectedDay);
    });
  }

  List<Events> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  void _removeEvent(DateTime selectedDay, Events event) {
    setState(() {
      events[selectedDay]?.remove(event);
      if (events[selectedDay]?.isEmpty ?? false) {
        events.remove(selectedDay);
      }
      _selectedEvents.value = _getEventsForDay(selectedDay);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calendar',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color(0xFF234469),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                scrollable: true,
                title: const Text("Event Name"),
                content: Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    controller: _eventController,
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      if (_eventController.text.isNotEmpty) {
                        setState(() {
                          if (events[_selectedDay] != null) {
                            events[_selectedDay]!
                                .add(Events(_eventController.text));
                          } else {
                            events[_selectedDay!] = [
                              Events(_eventController.text)
                            ];
                          }
                        });

                        _eventController.clear(); // Clear the input
                        Navigator.of(context).pop();
                        _selectedEvents.value =
                            _getEventsForDay(_selectedDay!);
                      }
                    },
                    child: const Text("Submit"),
                  )
                ],
              );
            },
          );
        },
        backgroundColor: const Color(0xFF234469),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : scholarships.isEmpty
              ? const Center(child: Text('No more notifications'))
              : content(),
    );
  }

  Widget content() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Material(
            elevation: 2.0,
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            child: TableCalendar(
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
              ),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              firstDay: DateTime.utc(2010, 10, 10),
              lastDay: DateTime.utc(2030, 3, 14),
              onDaySelected: _onDaySelected,
              eventLoader: _getEventsForDay,
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
                defaultTextStyle: TextStyle(color: Colors.black),
                todayTextStyle: TextStyle(color: Colors.white),
                weekendTextStyle: TextStyle(color: Colors.red), // Set weekend text to red
                selectedDecoration: BoxDecoration(
                  color: Color(0xFF234469), // Customize selected day background
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: TextStyle(color: Colors.white),
              ),
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),

          // First ListView.builder for events
          Expanded(
            flex: 1,  // Use flex to adjust the space if needed
            child: ValueListenableBuilder(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
  itemCount: value.length,
  itemBuilder: (context, index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),  // Add space between items
      child: Dismissible(
        key: Key(value[index].toString()),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          // Remove the event from the events map
          _removeEvent(_selectedDay!, value[index]);

          // Trigger a rebuild to reflect the changes
          setState(() {});

          // Show a snack bar as feedback
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Event deleted'),
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
        child: Material(
          elevation: 2.0,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: ListTile(
              title: Text(
                "${value[index]}",
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  },
);

              },
            ),
          ),

          const SizedBox(
            height: 8.0,
          ),

          // Second ListView.builder for notifications
          Expanded(
            flex: 1,  // Adjust space for the second list
            child: scholarships.isNotEmpty
                ? ListView.builder(
                    itemCount: scholarships.length,
                    itemBuilder: (context, index) {
                      final scholarship = scholarships[index];
                      return Dismissible(
                        key: Key(notificationIds[index].toString()), // Ensure unique key for each item
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          // Get the notificationId to be passed to removeNotificationById method
                          int notificationId = notificationIds[index];

                          // Remove the item from both lists and update the UI
                          setState(() {
                            scholarships.removeAt(index);  // Remove the scholarship at the given index
                            notificationIds.removeAt(index);  // Remove the notificationId at the given index
                          });

                          // Call the method to remove the notification by its ID in Firestore (if needed)
                          _userScholarship.removeNotificationById(notificationId);

                          // Show a snackbar for the action
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


class NotificationItem extends StatelessWidget {
  final String name;
  final String deadline;

  const NotificationItem({
    required this.name,
    required this.deadline,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: ListTile(
            leading: const Icon(Icons.notifications, color: Color(0xFF234469), size: 40),
            title: Text(
              name,
              style: const TextStyle(fontSize: 16),
            ),
            subtitle: Text(
              'Deadline: $deadline',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            trailing: const Icon(Icons.circle, size: 16, color: Colors.red),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          ),
        ),
      ),
    );
  }
}

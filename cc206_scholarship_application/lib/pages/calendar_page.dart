import 'package:cc206_scholarship_application/database/fetchAllScholarship.dart';
import 'package:cc206_scholarship_application/database/scholarship.dart';
import 'package:cc206_scholarship_application/database/userScholarship.dart';
import 'package:cc206_scholarship_application/includes/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

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
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
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
    
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<Events>> events = {};
  TextEditingController _eventController = TextEditingController();
  late final ValueNotifier<List<Events>> _selectedEvents;

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
      // Add button to add new event
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
                            events[_selectedDay]!.add(Events(_eventController.text));
                          } else {
                            events[_selectedDay!] = [Events(_eventController.text)];
                          }
                        });

                        _eventController.clear(); // Clear the input
                        Navigator.of(context).pop();
                        _selectedEvents.value = _getEventsForDay(_selectedDay!);
                      }
                    },
                    child: const Text("Submit"),
                  )
                ],
              );
            });
        },
        backgroundColor: const Color(0xFF234469),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      
      // Display content of page if there are notifications and if not, it will not display any notificaitons
      body: _isLoading
    ? const Center(child: CircularProgressIndicator())
    : notificationIds.isEmpty
        ? const Center(child: Text('No more notifications'))
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Material(
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
                      weekendTextStyle: TextStyle(color: Colors.red),
                      selectedDecoration: BoxDecoration(
                        color: Color(0xFF234469),
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
              ),

              // Same notifications from notifications page
              Expanded(
                child: notificationIds.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ListView.builder(
                          itemCount: notificationIds.length,
                          itemBuilder: (context, index) {
                            final scholarship = scholarships[index];
                            return Dismissible(
                              key: Key(notificationIds[index].toString()),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                int notificationId = notificationIds[index];
                                setState(() {
                                  scholarships.removeAt(index);
                                  notificationIds.removeAt(index);
                                });
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
                        ),
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

              // List of added events
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: _selectedEvents,
                  builder: (context, value, _) {
                    return ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return Material(
                          elevation: 2.0,
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: ListTile(
                              title: Text("${value[index]}", style: const TextStyle(fontSize: 16)),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),

    );
  }
}
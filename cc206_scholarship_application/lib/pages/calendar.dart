import 'package:cc206_scholarship_application/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cc206_scholarship_application/pages/notifications_page.dart';
import 'package:cc206_scholarship_application/pages/profile_page.dart';
import 'events.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _MyAppState();
}

class _MyAppState extends State<Calendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<Events>> events = {};
  TextEditingController _eventController = TextEditingController();
  late final ValueNotifier<List<Events>> _selectedEvents;
  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
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
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    scrollable: true,
                    title: Text("Event Name"),
                    content: Padding(
                      padding: EdgeInsets.all(8),
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
                        child: Text("Submit"),
                      )
                    ],
                  );
                });
          },
          child: Icon(Icons.add)),
      body: content(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 2, // Set index to Home
        onTap: (index) {
          // Navigation logic
          switch (index) {
            case 0:
              // nothing
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationsPage()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const HomePage()),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Profile()),
              );
              break;
            case 4:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Profile()),
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, color: Colors.deepOrange),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, color: Colors.grey),
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

  Widget content() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          //Text("Selected Day =" + today.toString().split(" ")[0]),
          Container(
              child: TableCalendar(
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
            ),
            availableGestures: AvailableGestures.all,
            selectedDayPredicate: (day) => isSameDay(day, _focusedDay),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            firstDay: DateTime.utc(2010, 10, 10),
            lastDay: DateTime.utc(2030, 3, 14),
            onDaySelected: _onDaySelected,
            eventLoader: _getEventsForDay,
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              defaultTextStyle: TextStyle(color: Colors.blue), // Font color
              todayTextStyle: TextStyle(color: Colors.white),
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
          )),
          SizedBox(
            height: 8.0,
          ),
          Expanded(
            child: ValueListenableBuilder(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  return ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(12),
                              color: Color(0xFFFF8A65)),
                          child: ListTile(
                            onTap: () => print(""),
                            title: Text("${value[index]}",
                                style: const TextStyle(fontSize: 16)),
                          ),
                        );
                      });
                }),
          )
        ],
      ),
    );
  }
}

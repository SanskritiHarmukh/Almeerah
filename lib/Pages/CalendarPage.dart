import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'dart:math';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late DateTime selectedDay = DateTime.now();
  List<CleanCalendarEvent> selectedEvent = [];

  final Map<DateTime, List<CleanCalendarEvent>> events = {};

  Color getRandomColor() {
    final random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1.0,
    );
  }

  void setupEventsForYear(int year) {
    for (int month = 1; month <= 12; month++) {
      for (int day = 1; day <= DateTime(year, month + 1, 0).day; day++) {
        final date = DateTime(year, month, day);
        List<CleanCalendarEvent> dayEvents = [
          CleanCalendarEvent(
            'Wear this color today!', // Custom message to wear the color
            color: getRandomColor(), // Random color for each day
            startTime: DateTime(year, month, day),
            endTime: DateTime(year, month, day),
          ),
        ];
        events[date] = dayEvents;
      }
    }
  }

  void _handleData(DateTime date) {
    setState(() {
      selectedDay = date;
      selectedEvent = events[selectedDay] ?? [];
    });
    print(selectedDay);
  }

  @override
  void initState() {
    // Set up events for the year 2023 as an example
    setupEventsForYear(2023);
    selectedEvent = events[selectedDay] ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: Text('Calendar'),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 2,
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 16),
            child: Calendar(
              startOnMonday: true,
              weekDays: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
              selectedColor: Theme.of(context).colorScheme.primary.withOpacity(.5),
              todayColor: Colors.red,
              eventColor: Colors.grey,
              eventDoneColor: Colors.amber,
              bottomBarColor: Colors.deepOrange,
              onRangeSelected: (range) {
                print('selected Day ${range.from},${range.to}');
              },
              onDateSelected: (date) {
                return _handleData(date);
              },
              events: events,
              isExpanded: true,
              dayOfWeekStyle: TextStyle(
                fontSize: 15,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
              bottomBarTextStyle: TextStyle(
                color: Colors.blue,
              ),
              hideBottomBar: false,
              hideArrows: false,
              
            ),
          ),
        ),
      );
  }
}

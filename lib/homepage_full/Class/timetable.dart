import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TimeTablePage extends StatefulWidget {
  @override
  _TimeTablePageState createState() => _TimeTablePageState();
}

class _TimeTablePageState extends State<TimeTablePage> {
  DateTime _selectedDate = DateTime.now();
  List<String> _selectedDays = ['20', '', ''];
  List<Map<String, String>> _timeTableList = [
    {
      'subject': 'Maths',
      'details': 'Algebra and Calculus',
      'teacher': 'John Doe',
      'time': '9:00 AM - 10:00 AM'
    },
    {
      'subject': 'Science',
      'details': 'Physics and Chemistry',
      'teacher': 'Jane Smith',
      'time': '10:00 AM - 11:00 AM'
    },
    {
      'subject': 'History',
      'details': 'World Wars and Revolutions',
      'teacher': 'Bob Brown',
      'time': '11:00 AM - 12:00 PM'
    },
  ];

  Widget _buildCalendar() {
    return TableCalendar(
      focusedDay: _selectedDate,
      firstDay: DateTime.utc(2023),
      lastDay: DateTime.utc(2024),
      selectedDayPredicate: (day) => _selectedDays.contains(day.day.toString()),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDate = focusedDay;
        });
      },
    );
  }

  Widget _buildTimeTableList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _timeTableList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_timeTableList[index]['subject']!),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_timeTableList[index]['details']!),
              Text('Teacher: ${_timeTableList[index]['teacher']}'),
              Text('Time: ${_timeTableList[index]['time']}'),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Table'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCalendar(),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Time Table for ${_selectedDate.day}-${_selectedDate.month}-${_selectedDate.year}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 16),
          Expanded(child: _buildTimeTableList()),
        ],
      ),
    );
  }
}

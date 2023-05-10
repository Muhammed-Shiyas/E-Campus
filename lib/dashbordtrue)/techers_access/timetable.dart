import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TimeTablePage extends StatefulWidget {
  const TimeTablePage({Key? key}) : super(key: key);

  @override
  State<TimeTablePage> createState() => _TimeTablePageState();
}

class _TimeTablePageState extends State<TimeTablePage> {
  late DateTime _selectedDate;
  late final DateTime _selectedDateOnly;
  List<TextEditingController> _subjectControllers =
      List.generate(6, (_) => TextEditingController());
  List<TextEditingController> _teacherControllers =
      List.generate(6, (_) => TextEditingController());
  List<TextEditingController> _detailsControllers =
      List.generate(6, (_) => TextEditingController());
  List<TextEditingController> _timeControllers =
      List.generate(6, (_) => TextEditingController());

  CalendarFormat _calendarFormat = CalendarFormat.month;

  List<Map<String, String>> _tableData = [];
  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _selectedDateOnly = DateTime(picked.year, picked.month, picked.day);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedDateOnly =
        DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day);
    _tableData = List.generate(
      6,
      (index) => {
        'subject': '',
        'teacher': '',
        'details': '',
        'time': '',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              TableCalendar(
                focusedDay: _selectedDate,
                firstDay: DateTime.now().subtract(Duration(days: 365)),
                lastDay: DateTime.now().add(Duration(days: 365)),
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDate, day);
                },
                onDaySelected: (date, events) {
                  setState(() {
                    _selectedDate = date;
                  });
                },
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
              ),
              SizedBox(height: 16),
              Text(
                'Selected Date: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Column(
                children: _tableData
                    .asMap()
                    .entries
                    .map((entry) => _buildTableRow(entry.key))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTableRow(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: TextField(
              controller: _subjectControllers[index],
              decoration: InputDecoration(
                hintText: 'Subject',
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: TextField(
              controller: _teacherControllers[index],
              decoration: InputDecoration(
                hintText: 'Teacher',
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: TextField(
              controller: _detailsControllers[index],
              decoration: InputDecoration(
                hintText: 'Details',
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: TextField(
              controller: _timeControllers[index],
              decoration: InputDecoration(
                hintText: 'Time',
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _tableData[index]['subject'] = _subjectControllers[index].text;
                _tableData[index]['teacher'] = _teacherControllers[index].text;
                _tableData[index]['details'] = _detailsControllers[index].text;
                _tableData[index]['time'] = _timeControllers[index].text;
              });
              _subjectControllers[index].clear();
              _teacherControllers[index].clear();
              _detailsControllers[index].clear();
              _timeControllers[index].clear();
              _addDataToFirestore();
            },
            icon: Icon(Icons.save),
          )
        ],
      ),
    );
  }

  void _addDataToFirestore() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('students')
        .doc('TIMETABLEADD')
        .get();
    final departments = ['BCA', 'DCFS', 'CS', 'AIML'];
    final timetable_depaertments = [
      'timetableAIML',
      'timetableCS',
      'timetableBCA',
      'timetableDCFS'
    ];
    final years = ['1', '2', '3'];
    final divisions = ['A', 'B', 'C'];
    final semesters = ['1', '2', '3', '4', '5', '6'];

    for (final department in departments) {
      if (userDoc.get('Department') == department) {
        for (final timetable_depaertment in timetable_depaertments) {
          if (userDoc.get('timetable_depaertment') == timetable_depaertment) {
            for (final year in years) {
              if (userDoc.get('year') == year) {
                for (final division in divisions) {
                  if (userDoc.get('division') == division) {
                    for (final sem in semesters) {
                      if (userDoc.get('sem') == sem) {
                        // add user's details to students collection
                        await FirebaseFirestore.instance
                            .collection('students')
                            .doc(department)
                            .collection(timetable_depaertment)
                            .doc('$year YEAR')
                            .collection('division')
                            .doc(division)
                            .collection('SEM')
                            .doc('$sem SEM')
                            .collection('timetable')
                            .doc(_selectedDateOnly.toString())
                            .set({
                          'subject_1': _tableData[0]['subject'],
                          'teacher_1': _tableData[0]['teacher'],
                          'details_1': _tableData[0]['details'],
                          'time_1': _tableData[0]['time'],
                          'subject_2': _tableData[1]['subject'],
                          'teacher_2': _tableData[1]['teacher'],
                          'details_2': _tableData[1]['details'],
                          'time_2': _tableData[1]['time'],
                          'subject_3': _tableData[2]['subject'],
                          'teacher_3': _tableData[2]['teacher'],
                          'details_3': _tableData[2]['details'],
                          'time_3': _tableData[2]['time'],
                          'subject_4': _tableData[3]['subject'],
                          'teacher_4': _tableData[3]['teacher'],
                          'details_4': _tableData[3]['details'],
                          'time_4': _tableData[3]['time'],
                          'subject_5': _tableData[4]['subject'],
                          'teacher_5': _tableData[4]['teacher'],
                          'details_5': _tableData[4]['details'],
                          'time_5': _tableData[4]['time'],
                          'subject_6': _tableData[5]['subject'],
                          'teacher_6': _tableData[5]['teacher'],
                          'details_6': _tableData[5]['details'],
                          'time_6': _tableData[5]['time'],
                        });
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}

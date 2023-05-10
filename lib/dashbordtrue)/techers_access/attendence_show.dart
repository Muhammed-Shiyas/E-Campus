import 'package:flutter/material.dart';

class AttendancePage1 extends StatefulWidget {
  const AttendancePage1({Key? key}) : super(key: key);

  @override
  _AttendancePage1State createState() => _AttendancePage1State();
}

class _AttendancePage1State extends State<AttendancePage1> {
  List<Student> students = [
    Student(name: 'muhammed shiyas', regNumber: '2022j0921', isPresent: true),
    Student(name: 'muhammed fasil', regNumber: '2022j0902', isPresent: true),
    Student(name: 'aghil', regNumber: '2022j0904', isPresent: true),
    Student(name: 'jeevan', regNumber: '2022j09014', isPresent: true),
    Student(name: 'muhammed shiyas', regNumber: '2022j0921', isPresent: true),
    Student(name: 'muhammed fasil', regNumber: '2022j0902', isPresent: true),
    Student(name: 'aghil', regNumber: '2022j0904', isPresent: true),
    Student(name: 'jeevan', regNumber: '2022j09014', isPresent: true),
    Student(name: 'muhammed shiyas', regNumber: '2022j0921', isPresent: true),
    Student(name: 'muhammed fasil', regNumber: '2022j0902', isPresent: true),
    Student(name: 'aghil', regNumber: '2022j0904', isPresent: true),
    Student(name: 'jeevan', regNumber: '2022j09014', isPresent: true),
    Student(name: 'muhammed shiyas', regNumber: '2022j0921', isPresent: true),
    Student(name: 'muhammed fasil', regNumber: '2022j0902', isPresent: true),
    Student(name: 'aghil', regNumber: '2022j0904', isPresent: true),
    Student(name: 'jeevan', regNumber: '2022j09014', isPresent: true),
  ];

  bool _isSaved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              setState(() {
                _isSaved = true;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Attendance saved successfully'),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(students[index].name),
            subtitle: Text('Reg. No: ${students[index].regNumber}'),
            trailing: students[index].isPresent
                ? ElevatedButton(
                    onPressed: () {
                      setState(() {
                        students[index].isPresent = false;
                      });
                    },
                    child: Text('Present'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                  )
                : ElevatedButton(
                    onPressed: () {
                      setState(() {
                        students[index].isPresent = true;
                      });
                    },
                    child: Text('Absent'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                  ),
          );
        },
      ),
    );
  }
}

class Student {
  final String name;
  final String regNumber;
  bool isPresent;

  Student({
    required this.name,
    required this.regNumber,
    required this.isPresent,
  });
}

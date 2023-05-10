import 'dart:math';

import 'package:flutter/material.dart';

class AttendancePage extends StatelessWidget {
  final double overallAttendance;
  final Map<String, double> subjectAttendance;

  AttendancePage(
      {required this.overallAttendance, required this.subjectAttendance});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200.0,
              width: 200.0,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: CirclePainter(
                        progress: overallAttendance,
                        backgroundColor: Colors.grey[300]!,
                        foregroundColor: Colors.blue,
                        strokeWidth: 10.0,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      '${overallAttendance.toStringAsFixed(1)}%',
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50.0),
            Column(
              children: subjectAttendance.entries.map((entry) {
                final String subject = entry.key;
                final double attendance = entry.value;
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          subject,
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Expanded(
                        flex: 2,
                        child: CustomPaint(
                          painter: BarPainter(
                            progress: attendance,
                            backgroundColor: Colors.grey[300]!,
                            foregroundColor: Colors.blue,
                            strokeWidth: 10.0,
                          ),
                          child: SizedBox(
                            height: 30.0,
                            child: Center(
                              child: Text(
                                '${attendance.toStringAsFixed(1)}%',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final double progress;
  final Color backgroundColor;
  final Color foregroundColor;
  final double strokeWidth;

  CirclePainter({
    required this.progress,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, backgroundPaint);

    final foregroundPaint = Paint()
      ..shader = SweepGradient(
        startAngle: 0.0,
        endAngle: 2 * pi * progress / 100,
        colors: [foregroundColor, foregroundColor],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress / 100,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.foregroundColor != foregroundColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

class BarPainter extends CustomPainter {
  final double progress;
  final Color backgroundColor;
  final Color foregroundColor;
  final double strokeWidth;

  BarPainter({
    required this.progress,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0.0, 0.0, size.width, size.height),
        Radius.circular(size.height / 2),
      ),
      backgroundPaint,
    );

    final foregroundPaint = Paint()
      ..color = foregroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0.0, 0.0, progress / 100 * size.width, size.height),
        Radius.circular(size.height / 2),
      ),
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(BarPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.foregroundColor != foregroundColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

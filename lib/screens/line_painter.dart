import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  Offset point1;
  Offset point2;
  Offset pointOrigin;
  Offset px;
  MyPainter(
      {required this.point1,
      required this.point2,
      required this.pointOrigin,
      required this.px});

  @override
  void paint(Canvas canvas, Size size) {
    final p1 = point1;
    final p2 = point2;
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 5;

    canvas.drawLine(Offset((p1.dx - px.dx) + 50, (p1.dy - pointOrigin.dy) + 25),
        Offset((p2.dx - px.dx) + 50, (p2.dy - pointOrigin.dy) + 25), paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}

class SnakePainter extends CustomPainter {
  Offset point1;
  Offset point2;
  Offset pointOrigin;
  Offset px;
  SnakePainter(
      {required this.point1,
      required this.point2,
      required this.pointOrigin,
      required this.px});

  @override
  void paint(Canvas canvas, Size size) {
    final p1 = point1;
    final p2 = point2;
    final paint = Paint()
      ..color = Colors.yellow
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;
    canvas.drawLine(Offset((p1.dx - px.dx) + 50, (p1.dy - pointOrigin.dy) + 25),
        Offset((p2.dx - px.dx) + 50, (p2.dy - pointOrigin.dy) + 25), paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}

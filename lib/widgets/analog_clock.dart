import 'dart:math';
import 'package:flutter/material.dart';

class ModernAnalogClock extends StatelessWidget {
  final DateTime dateTime;
  final double size;

  const ModernAnalogClock({
    super.key,
    required this.dateTime,
    this.size = 300,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
        boxShadow: [
          // Outer Radiant Pink Glow
          BoxShadow(
            color: const Color(0xFFFF1493).withOpacity(0.35),
            blurRadius: 35,
            spreadRadius: 5,
          ),
          BoxShadow(
            color: const Color(0xFFFF69B4).withOpacity(0.15),
            blurRadius: 60,
            spreadRadius: 15,
          ),
        ],
      ),
      child: CustomPaint(
        size: Size(size, size),
        painter: AnalogClockPainter(dateTime: dateTime),
      ),
    );
  }
}

class AnalogClockPainter extends CustomPainter {
  final DateTime dateTime;

  AnalogClockPainter({required this.dateTime});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // --- Background Circle Dial Border ---
    final borderPaint = Paint()
      ..color = const Color(0xFFFF1493).withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawCircle(center, radius - 4, borderPaint);

    // --- Draw Ticks & Numbers (1-12) ---
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    for (int i = 1; i <= 60; i++) {
      final angle = (i * 6) * (pi / 180);
      final isHourTick = i % 5 == 0;

      final tickLength = isHourTick ? 12.0 : 6.0;
      final tickWidth = isHourTick ? 2.5 : 1.0;

      final outerX = center.dx + (radius - 12) * cos(angle - pi / 2);
      final outerY = center.dy + (radius - 12) * sin(angle - pi / 2);
      final innerX = center.dx + (radius - 12 - tickLength) * cos(angle - pi / 2);
      final innerY = center.dy + (radius - 12 - tickLength) * sin(angle - pi / 2);

      final tickPaint = Paint()
        ..color = isHourTick
            ? const Color(0xFFFF69B4)
            : Colors.white.withOpacity(0.5)
        ..strokeWidth = tickWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(Offset(innerX, innerY), Offset(outerX, outerY), tickPaint);
    }

    // Numbers 1 to 12
    for (int i = 1; i <= 12; i++) {
      final hourAngle = (i * 30) * (pi / 180);
      final numRadius = radius - 38;
      final x = center.dx + numRadius * cos(hourAngle - pi / 2);
      final y = center.dy + numRadius * sin(hourAngle - pi / 2);

      textPainter.text = TextSpan(
        text: '$i',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto',
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, y - textPainter.height / 2),
      );
    }

    // --- Calculate Rotations ---
    final secondsAngle = (dateTime.second * 6) * (pi / 180);
    final minutesAngle =
        (dateTime.minute * 6 + dateTime.second * 0.1) * (pi / 180);
    final hoursAngle =
        ((dateTime.hour % 12) * 30 + dateTime.minute * 0.5) * (pi / 180);

    // --- Hour Hand ---
    _drawHand(
      canvas: canvas,
      center: center,
      angle: hoursAngle,
      length: radius * 0.5,
      width: 6.0,
      color: Colors.white,
      glowColor: const Color(0xFFFF1493),
    );

    // --- Minute Hand ---
    _drawHand(
      canvas: canvas,
      center: center,
      angle: minutesAngle,
      length: radius * 0.72,
      width: 4.0,
      color: const Color(0xFFFFB6C1),
      glowColor: const Color(0xFFFF1493),
    );

    // --- Second Hand (Radiant Neon Pink) ---
    _drawHand(
      canvas: canvas,
      center: center,
      angle: secondsAngle,
      length: radius * 0.85,
      width: 2.0,
      color: const Color(0xFFFF1493),
      glowColor: const Color(0xFFFF69B4),
      hasTail: true,
    );

    // --- Center Pivot ---
    final pivotGlow = Paint()
      ..color = const Color(0xFFFF1493)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.drawCircle(center, 7, pivotGlow);

    final pivotOuter = Paint()..color = const Color(0xFFFF1493);
    canvas.drawCircle(center, 6, pivotOuter);

    final pivotInner = Paint()..color = Colors.black;
    canvas.drawCircle(center, 2.5, pivotInner);
  }

  void _drawHand({
    required Canvas canvas,
    required Offset center,
    required double angle,
    required double length,
    required double width,
    required Color color,
    required Color glowColor,
    bool hasTail = false,
  }) {
    final endX = center.dx + length * cos(angle - pi / 2);
    final endY = center.dy + length * sin(angle - pi / 2);

    final startX = hasTail
        ? center.dx - 15 * cos(angle - pi / 2)
        : center.dx;
    final startY = hasTail
        ? center.dy - 15 * sin(angle - pi / 2)
        : center.dy;

    // Hand Glow Effect
    final glowPaint = Paint()
      ..color = glowColor.withOpacity(0.6)
      ..strokeWidth = width + 4
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawLine(Offset(startX, startY), Offset(endX, endY), glowPaint);

    // Solid Hand Line
    final handPaint = Paint()
      ..color = color
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(startX, startY), Offset(endX, endY), handPaint);
  }

  @override
  bool shouldRepaint(covariant AnalogClockPainter oldDelegate) {
    return oldDelegate.dateTime != dateTime;
  }
}
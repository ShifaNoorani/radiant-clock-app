import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ModernDigitalClock extends StatelessWidget {
  final DateTime dateTime;

  const ModernDigitalClock({
    super.key,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    final String timeString = DateFormat('hh:mm:ss').format(dateTime);
    final String amPm = DateFormat('a').format(dateTime);
    final String fullDate = DateFormat('EEEE, MMMM d, yyyy').format(dateTime);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Digital Clock Row
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                timeString,
                style: TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.0,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: const Color(0xFFFF1493).withOpacity(0.8),
                      blurRadius: 18,
                    ),
                    Shadow(
                      color: const Color(0xFFFF69B4).withOpacity(0.5),
                      blurRadius: 30,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                amPm,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFFF69B4),
                  shadows: [
                    Shadow(
                      color: const Color(0xFFFF1493).withOpacity(0.8),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Full Date Container
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFFF1493).withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xFFFF1493).withOpacity(0.4),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF1493).withOpacity(0.15),
                blurRadius: 12,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Text(
            fullDate,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFFFFB6C1),
              letterSpacing: 0.8,
            ),
          ),
        ),
      ],
    );
  }
}
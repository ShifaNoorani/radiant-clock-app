import 'dart:async';
import 'package:flutter/material.dart';
import 'widgets/analog_clock.dart';
import 'widgets/digital_clock.dart';

void main() {
  runApp(const RadiantClockApp());
}

class RadiantClockApp extends StatelessWidget {
  const RadiantClockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radiant Clock',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const RadiantClockScreen(),
    );
  }
}

class RadiantClockScreen extends StatefulWidget {
  const RadiantClockScreen({super.key});

  @override
  State<RadiantClockScreen> createState() => _RadiantClockScreenState();
}

class _RadiantClockScreenState extends State<RadiantClockScreen> {
  late DateTime _dateTime;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _dateTime = DateTime.now();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.2,
            colors: [
              Color(0xFFFF1493).withOpacity(0.08),
              Colors.black,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 720) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 32.0),
                              child: ModernDigitalClock(dateTime: _dateTime),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 32.0),
                              child: ModernAnalogClock(
                                dateTime: _dateTime,
                                size: 320,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ModernDigitalClock(dateTime: _dateTime),
                        const SizedBox(height: 48),
                        ModernAnalogClock(
                          dateTime: _dateTime,
                          size: 260,
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
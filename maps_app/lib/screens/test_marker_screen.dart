import 'package:flutter/material.dart';
import 'package:maps_app/markers/start_marker.dart';

class TestMarkerScreen extends StatelessWidget {
  const TestMarkerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 350,
          height: 150,
          child: CustomPaint(
            painter: StartMarkerPainter(),
          ),
        ),
      ),
    );
  }
}

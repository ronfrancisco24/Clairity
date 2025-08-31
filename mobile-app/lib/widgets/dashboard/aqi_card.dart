import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';

class AqiCard extends StatelessWidget {
  const AqiCard({
    super.key,
    required this.value,
    required this.status,
  });

  final double value;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 8),
          const SizedBox(height: 2),
          SizedBox(
            height: 125,
            child: Stack(children: [
              AnimatedRadialGauge(
                duration: Duration(seconds: 1),
                curve: Curves.elasticOut,
                radius: 100,
                value: value,
                axis: const GaugeAxis(
                  min: 0,
                  max: 200,
                  degrees: 240,
                  style: GaugeAxisStyle(
                    thickness: 20,
                    background: Color(0xFFDFDFDF),
                    segmentSpacing: 4,
                  ),
                  progressBar: GaugeProgressBar.rounded(
                    gradient: GaugeAxisGradient(
                      colors: [
                        Color(0xFF00E400), // Good
                        Color(0xFFFFFF00), // Moderate
                        Color(0xFFFF7E00), // Unhealthy for Sensitive
                        Color(0xFFFF0000), // Unhealthy
                      ],
                      colorStops: [
                        0.0,
                        0.33,
                        0.66,
                        1.0
                      ], // Optional: control color positions
                    ),
                  ),
                  pointer: GaugePointer.circle(
                    radius: 10,
                    color: Colors.white,
                    border: GaugePointerBorder(
                      color: Colors.black,
                      width: 3,
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    value.toStringAsFixed(0),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ]),
          ),
          const SizedBox(height: 10),
          Text(
            status,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }
}

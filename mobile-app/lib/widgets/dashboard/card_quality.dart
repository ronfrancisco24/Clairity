import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CardQuality extends StatelessWidget {
  const CardQuality({
    super.key,
    required this.onTap,
    required this.trendLabel,
    required this.trendValue,
    required this.trendLevel,
  });

  final VoidCallback onTap;
  final String trendLabel;
  final String trendValue;
  final String trendLevel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black), // Black border
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              trendLabel,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 80,
              width: double.infinity,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    // TODO: use trends here from firestore data.
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 1),
                        FlSpot(1, 1.5),
                        FlSpot(2, 1.4),
                        FlSpot(3, 3.4),
                        FlSpot(4, 2),
                        FlSpot(5, 2.2),
                        FlSpot(6, 1.8),
                      ],
                      isCurved: true,
                      color: Colors.blueAccent,
                      barWidth: 4,
                      dotData: FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            // TrendLevel above TrendValue, both left-aligned, arrow right
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trendLevel,
                      style: const TextStyle(
                        color: Colors.black38,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      trendValue,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black54),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
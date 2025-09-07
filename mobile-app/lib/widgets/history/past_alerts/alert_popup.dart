import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../utils/alert_utils.dart';
import '../../../utils/dashboard_utils.dart';
import '../../../utils/history_utils.dart';

class AlertPopup extends StatelessWidget {
  final DateTime time;
  final String? sensorId;
  final String? description;
  final double? aqiValue;
  final String? aqiCategory;
  final int level;

  const AlertPopup({
    super.key,
    required this.time,
    required this.sensorId,
    required this.description,
    required this.aqiValue,
    required this.aqiCategory,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final textScale = MediaQuery.of(context).textScaler;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: screenSize.width * 0.9,
          maxHeight: screenSize.height * 0.7,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  aqiCategory ?? "Unknown",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: textScale.scale(20),
                  ),
                ),
                SizedBox(height: screenSize.height * 0.03),

                // Time & Sensor Info
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _InfoColumn(
                      icon: Icons.access_time_outlined,
                      label: "Time Recorded",
                      value: getFormattedTime(time),
                    ),
                    _InfoColumn(
                      icon: Icons.location_on_outlined,
                      label: "Sensor",
                      value: sensorId ?? "Unknown",
                    ),
                  ],
                ),
                SizedBox(height: screenSize.height * 0.04),

                // Description
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Description",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: textScale.scale(22),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description ?? "No description available",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: textScale.scale(15)),
                ),
                SizedBox(height: screenSize.height * 0.04),

                // AQI Reading
                Text(
                  "Air Quality Reading",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: textScale.scale(20),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '${aqiValue?.toStringAsFixed(0) ?? "--"}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: textScale.scale(40),
                    color: AlertUtils().getLevelColor(level),
                  ),
                ),
                Text(
                  "AQI Level",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: textScale.scale(18),
                    color: AlertUtils().getLevelColor(level),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoColumn extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoColumn({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaler;

    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: textScale.scale(18)),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(fontSize: textScale.scale(14)),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontSize: textScale.scale(14)),
        ),
      ],
    );
  }
}

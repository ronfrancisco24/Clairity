import 'package:flutter/material.dart';

class CardStatusSensor extends StatelessWidget {
  const CardStatusSensor({
    super.key,
    required this.value,
    required this.maxValue,
    required this.label,
    required this.progress,
    this.progressColor = Colors.redAccent,
  });

  final int value;
  final int maxValue;
  final String label;
  final double progress;
  final Color progressColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$value/$maxValue',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 2),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.black12,
            color: progressColor,
            minHeight: 4,
          ),
        ],
      ),
    );
  }
}
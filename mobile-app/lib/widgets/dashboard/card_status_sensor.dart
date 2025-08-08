import 'package:flutter/material.dart';
import 'package:gradient_progress_bar/gradient_progress_bar.dart';

class CardStatusSensor extends StatelessWidget {
  const CardStatusSensor({
    super.key,
    required this.value,
    required this.maxValue,
    required this.label,
    required this.progress,
    this.progressColor = Colors.redAccent,
  });

  final double value;
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
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            child: Text(
              '$value/$maxValue',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 14),
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 16,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: GradientProgressIndicator(
                  [
                    Color(0xffF68270),
                    Color(0xffF1C358),
                    Color(0xffEFDE62),
                  ], progress),
            ),
          ),
        ],
      ),
    );
  }
}

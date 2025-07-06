import 'package:flutter/material.dart';

class CardCurrents extends StatelessWidget {
  const CardCurrents({
    super.key,
    required this.value,
    required this.low,
    required this.high,
    required this.status,
  });

  final int value;
  final int low;
  final int high;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 8),
          Text(
            '$value',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '$low    $high',
            style: const TextStyle(
              color: Colors.greenAccent,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            status,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
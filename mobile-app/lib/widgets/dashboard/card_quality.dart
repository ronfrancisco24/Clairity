import 'package:flutter/material.dart';

class CardQuality extends StatelessWidget {
  const CardQuality({
    super.key,
    required this.onTap,
    required this.trendLabel,
    required this.trendValue,
  });

  final VoidCallback onTap;
  final String trendLabel;
  final String trendValue;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black12),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              trendLabel,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const Spacer(),
            // Placeholder for graph
            Container(
              height: 32,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'Graph',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Low',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
                Text(
                  trendValue,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.black54),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
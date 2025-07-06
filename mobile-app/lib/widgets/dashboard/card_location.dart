import 'package:flutter/material.dart';

class CardLocation extends StatelessWidget {
  const CardLocation({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  });

  final String imageUrl;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          Image.network(
            imageUrl,
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
              color: Colors.white.withOpacity(0.85),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
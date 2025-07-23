// clairity_footer.dart
import 'package:flutter/material.dart';
import '../../../constants.dart'; // adjust the path if needed

class Footer extends StatelessWidget {
  final double width;
  final double height;

  const Footer({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          width: width * 0.6,
          height: height * 0.13,
          decoration: BoxDecoration(
            color: const Color(0xFFF4F6F3),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: oliveGreen, width: 1),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Development by:',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: oliveGreen,
                ),
              ),
              Text(
                'Clairity Team',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: mossGreen,
                ),
              ),
              Text('Holy Angel University'),
              Text(
                '© 2025 All rights reserved.',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

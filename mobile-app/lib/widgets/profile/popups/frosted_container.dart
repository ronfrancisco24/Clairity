import 'package:flutter/material.dart';

class FrostedContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final String text;

  const FrostedContainer({
    super.key,
    required this.width,
    required this.height,
    required this.color,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
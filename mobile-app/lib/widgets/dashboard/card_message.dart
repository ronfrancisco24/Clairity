import 'package:flutter/material.dart';

class CardMessage extends StatelessWidget {
  const CardMessage({
    super.key,
    required this.message,
    this.backgroundColor = Colors.black,
    this.textColor = Colors.white,
  });

  final String message;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(14),
      child: Text(
        message,
        style: TextStyle(
          color: textColor,
          fontSize: 18,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
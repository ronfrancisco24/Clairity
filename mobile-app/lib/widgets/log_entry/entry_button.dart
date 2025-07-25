import 'package:flutter/material.dart';
import '../../constants.dart';

class EntryButton extends StatelessWidget {
  final String text;
  final bool hasText;
  final Color color;
  final Color? textColor;
  final VoidCallback? onTap;

  const EntryButton(
      {super.key,
      required this.text,
      required this.color,
      required this.onTap,
      this.hasText = false,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 40,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey),
              color: hasText ? color : color.withOpacity(0.5),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

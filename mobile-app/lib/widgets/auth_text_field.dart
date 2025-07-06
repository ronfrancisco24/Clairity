import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String title;

  const AuthTextField({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2, color: Colors.white),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.white),
                labelText: '$title',
                border: InputBorder.none,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

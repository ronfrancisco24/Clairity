import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String title;

  const AuthTextField({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Stack(
        children: [
          Card(
            color: const Color(0xFFD9D9D9),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  labelText: 'Enter $title',
                  border: InputBorder.none,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
            ),
          ),
          Positioned(left: 20, top: -5, child: Text(title)),
        ],
      ),
    );
  }
}

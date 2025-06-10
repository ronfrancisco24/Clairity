import 'package:flutter/material.dart';

class SignButton extends StatelessWidget {
  const SignButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 100,
        height: 70,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ Color(0xFF0B334D),
              Color(0xFF477023),],
          ),
          borderRadius: BorderRadius.circular(20)
        ),
      ),
    );
  }
}

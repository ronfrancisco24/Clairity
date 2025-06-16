import 'package:flutter/material.dart';
import '';

class SocialButton extends StatelessWidget {
  const SocialButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        height: 30,
        width: 30,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset('images/google.jpg'),
        ),
      )
    );
  }
}

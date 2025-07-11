import 'package:flutter/material.dart';

class SignButton extends StatelessWidget {

  final VoidCallback? onTap;
  final String title;
  const SignButton({super.key, required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0B334D),
              Color(0xFF477023),
            ],
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // shadow color
              blurRadius: 10, // how blurry the shadow is
              offset: Offset(0, 4), // horizontal and vertical shift
            ),
          ],
        ),
        child: Center(
          child: Text(
            '$title',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),

    );
  }
}

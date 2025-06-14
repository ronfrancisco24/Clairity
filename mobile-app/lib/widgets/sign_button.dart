import 'package:flutter/material.dart';

class SignButton extends StatelessWidget {

  final VoidCallback? onTap;
  const SignButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
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
            borderRadius: BorderRadius.circular(15),
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
              'Sign Up',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),

    );
  }
}

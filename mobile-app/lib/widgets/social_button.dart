import 'package:flutter/material.dart';
import '';

class SocialButton extends StatelessWidget {

  final VoidCallback? onTap;
  const SocialButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
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
            'Sign in with Google',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
      ),

    );
  }
}

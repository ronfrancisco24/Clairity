import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;

  const SocialButton({super.key, required this.onTap, required this.title});

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
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            '$title Google',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            width: 25,
          ),
          SizedBox(
            height: 25,
            width: 25,
            child: CircleAvatar(
              backgroundImage: AssetImage('images/google.jpg'),
              backgroundColor: Colors.white,
            ),
          )
        ]),
      ),
    );
  }
}

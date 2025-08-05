import 'package:flutter/material.dart';
import 'retrieve_otp_screen.dart';
import 'sign_in_screen.dart';
import '../../constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RetrieveOtpScreen(),
            ),
          );
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: AppGradients.primaryGradient
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                  child: Image(image: AssetImage('images/logo.png'))
              ),
              SizedBox(height:30),
              Text(
                'Breathe Easy. Monitor Smarter',
                style: kSubheading
              )
            ],
          ),
        ),
      ),
    );
  }
}

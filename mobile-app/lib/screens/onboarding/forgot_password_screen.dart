import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../widgets/onboarding/auth_text_field.dart';
import 'reset_password_screen.dart';
import 'sign_up_screen.dart';
import '../../widgets/onboarding/sign_button.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xFF0B334D),
              Color(0xFF477023),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Center(
                  child: Image(image: AssetImage('images/logo.png')),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  alignment: Alignment.centerLeft,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Forgot Password', style: kHeading),
                      Text('Please enter your email.', style: kSubheading),
                    ],
                  ),
                ),
                Transform.translate(
                    offset: Offset(0, -20),
                    child: const AuthTextField(title: 'example@mail.com')),
                Transform.translate(
                  offset: Offset(0, -40),
                  child: SignButton(
                    title: 'Reset Password',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResetPasswordScreen(),
                        ),
                      );
                    },
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Terms & Conditions',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Support',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Customer Care',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

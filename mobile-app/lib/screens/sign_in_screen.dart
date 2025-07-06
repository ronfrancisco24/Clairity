import 'package:flutter/material.dart';
import '../widgets/bottomsheet.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/sign_button.dart';
import '../widgets/social_button.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool? isChecked = false;

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
                  child: Text(
                    'Clairity',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Just some details to get you in!',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const AuthTextField(title: 'Email/Phone'),
                const AuthTextField(title: 'Password'),
                const AuthTextField(title: 'Confirm Password'),
                SignButton(
                  onTap: () {},
                ),
                Container(
                  child: const Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Color(0xFF37964E),
                          thickness: 2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Or',
                          style: TextStyle(
                            color: Color(0xFF37964E),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Color(0xFF37964E),
                          thickness: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                SocialButton(
                  onTap: () {},
                ),
                const Center(
                  child: Text(
                    'Already Registered? Login Here.',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Terms & Conditions'),
                    Text('Support'),
                    Text('Customer Care')
                  ],
                ),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

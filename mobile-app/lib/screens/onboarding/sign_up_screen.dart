import 'package:flutter/material.dart';
import '../../widgets/onboarding/auth_text_field.dart';
import '../../widgets/onboarding/sign_button.dart';
import '../../widgets/onboarding/social_button.dart';
import '../../constants.dart';
import 'sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration:
            const BoxDecoration(gradient: AppGradients.secondaryGradient),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Center(
                    child: Image(image: AssetImage('images/logo.png'))),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Sign Up', style: kTitleMedium),
                      Text(
                        'Just some details to get you in!',
                        style: kTitleMedium,
                      ),
                    ],
                  ),
                ),
                const AuthTextField(title: 'Email/Phone'),
                const AuthTextField(
                  title: 'Password',
                  obscureText: true,
                ),
                const AuthTextField(
                  title: 'Confirm Password',
                  obscureText: true,
                ),
                SignButton(
                  title: 'Sign Up',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInScreen(),
                      ),
                    );
                  },
                ),
                Container(
                  child: const Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: greenAccent,
                          thickness: 3,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Or',
                          style: TextStyle(
                            color: greenAccent,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: greenAccent,
                          thickness: 3,
                        ),
                      ),
                    ],
                  ),
                ),
                SocialButton(
                  title: 'Sign in with ',
                  onTap: () {},
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(text: 'Already Registered? '),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignInScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Login Here',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        )
                      ],
                    ),
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

import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../widgets/onboarding/auth_text_field.dart';
import 'sign_in_screen.dart';
import '../../widgets/onboarding/sign_button.dart';
import '../../services/auth_service.dart';

class RetrieveOtpScreen extends StatelessWidget {
  RetrieveOtpScreen({super.key});

  final phoneController = TextEditingController();
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                      Text('Start with One Time Password.', style: kHeading),
                      Text(
                          'Please enter your phone number, to retrieve password.',
                          style: kSubheading),
                    ],
                  ),
                ),
                AuthTextField(
                  title: 'Phone No.',
                  controller: phoneController,
                ),
                SignButton(
                  // get OTP here
                  title: 'Get OTP',
                  onTap: () {
                    final phone = phoneController.text.trim();

                    if (phone.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Please enter your phone number")),
                      );
                      return;
                    }
                    authService.sendOTP(
                        phoneNumber: phone,
                        // pass verification back to Sign in screen.
                        onCodeSent: (verificationId) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SignInScreen(verificationId: verificationId),
                            ),
                          );
                        },
                        onError: (error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error: $error")),
                          );
                        });
                  },
                ),
                Divider(
                  color: greenAccent,
                  thickness: 3,
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
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

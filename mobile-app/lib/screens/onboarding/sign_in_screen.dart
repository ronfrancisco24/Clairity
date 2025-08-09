import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../utils/navbar_utils.dart';
import '../../widgets/onboarding/auth_text_field.dart';
import '../../constants.dart';
import '../../widgets/onboarding/sign_button.dart';
import '../../widgets/onboarding/onboarding_divider.dart';
import 'retrieve_otp_screen.dart';
import '../../services/auth_service.dart';

class SignInScreen extends StatefulWidget {
  final String? verificationId;

  const SignInScreen({super.key, this.verificationId});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool? isChecked = false;
  final authService = AuthService();
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Login', style: kHeading),
                      Text(
                        "Glad you're back!",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                AuthTextField(
                  hint: 'Enter Password / OTP',
                  showToggle: true,
                  controller: otpController,
                  type: 'OTP',
                ),
                SignButton(
                  title: 'Sign In',
                  onTap: () async {
                    final code = otpController.text.trim();

                    // if code is empty show snackbar/
                    if (code.isEmpty || widget.verificationId == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please get OTP first")),
                      );
                      return;
                    }

                    // verify OTP once verification ID is passed.
                    try {
                      await authService.verifyOTP(
                        verificationId: widget.verificationId!,
                        smsCode: code,
                      );

                      // Load user data after login
                      await Provider.of<UserProvider>(context, listen: false).loadUserData();

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const NavController()),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Invalid OTP: ${e.toString()}")),
                      );
                    }
                  },
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RetrieveOtpScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Get OTP here',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white),
                  ),
                ),
                const OnboardingDivider(),
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

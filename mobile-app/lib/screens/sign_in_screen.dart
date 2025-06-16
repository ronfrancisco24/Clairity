import 'package:flutter/material.dart';
import '../widgets/bottomsheet.dart';
import '../widgets/auth_text_field.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool? isChecked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // TODO: do something here.
    // call show modal bottom sheet.

    // to allow the state to be initialized first before show bottom sheet
    Future.delayed(Duration.zero, () {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: false,
        enableDrag: false,
        builder: (context) => Bottomsheet(
          formFields: [
            AuthTextField(title: 'Full Name'),
            AuthTextField(title: 'Email'),
            AuthTextField(title: 'Password'),
            AuthTextField(title: 'Confirm Password'),
          ],
          onSignUp: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignUpScreen(),
              ),
            );
          },
          isChecked: isChecked,
          showCheckbox: true,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xFF0B334D),
              Color(0xFF477023),
            ],
          ),
        ),
      ),
    );
  }
}

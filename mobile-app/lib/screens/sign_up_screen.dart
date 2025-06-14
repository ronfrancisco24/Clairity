import 'package:flutter/material.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/bottomsheet.dart';
import 'dashboard_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
            AuthTextField(title: 'Email'),
            AuthTextField(title: 'Password'),
          ],
          onSignUp: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DashboardScreen(),
              ),
            );
          },
          isChecked: isChecked,
          showCheckbox: false,
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

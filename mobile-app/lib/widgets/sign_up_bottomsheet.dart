import 'package:flutter/material.dart';
import 'auth_text_field.dart';
import 'sign_button.dart';

class SignUpBottomsheet extends StatelessWidget {
  const SignUpBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.68,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(40), topLeft: Radius.circular(40))),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Get Started',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            AuthTextField(title: 'Full Name'),
            AuthTextField(title: 'Email'),
            AuthTextField(title: 'Password'),
            AuthTextField(title: 'Confirm Password'),
            SignButton(),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                Text('Sign Up with'),
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            //TODO: add buttons for socials
            Text('Already have an account? Sign in!')
          ],
        ),
      ),
    );
  }
}

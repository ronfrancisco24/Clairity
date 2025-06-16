import 'package:flutter/material.dart';
import 'auth_text_field.dart';
import 'sign_button.dart';
import './social_button.dart';

class Bottomsheet extends StatefulWidget {
  final List<Widget> formFields;
  final VoidCallback onSignUp;
  final bool? isChecked;
  final bool? showCheckbox;

  const Bottomsheet({
    super.key,
    required this.formFields,
    required this.onSignUp,
    required this.isChecked,
    required this.showCheckbox
  });

  @override
  State<Bottomsheet> createState() => _BottomsheetState();
}

class _BottomsheetState extends State<Bottomsheet> {
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.75,
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40),
            topLeft: Radius.circular(40),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              'Get Started',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            ...widget.formFields,
            SignButton(onTap: widget.onSignUp),
            if (widget.showCheckbox == true)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  Text('I agree to the Processing of Data.'),
                ],
              ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                children: [
                  Expanded(child: Divider(thickness: 2, color: Colors.black)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('Sign Up with'),
                  ),
                  Expanded(child: Divider(thickness: 2, color: Colors.black)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SocialButton(),
                  SocialButton(),
                  SocialButton(),
                  SocialButton(),
                ],
              ),
            ),
            const Text('Already have an account? Sign in!'),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }
}

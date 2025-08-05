import 'package:flutter/material.dart';
import '../../constants.dart';

class OnboardingDivider extends StatelessWidget {
  const OnboardingDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

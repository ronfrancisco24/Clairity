import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/user_provider.dart';

void showOtpDialog(BuildContext context, String verificationId, Map<String, dynamic> userData) {
  final _otpController = TextEditingController();
  final userProvider = Provider.of<UserProvider>(context, listen: false);

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text("Verify OTP"),
      content: TextFormField(controller: _otpController, decoration: InputDecoration(labelText: "Enter OTP")),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
        ElevatedButton(
          onPressed: () {
            userProvider.verifyAndCreateUser(
              verificationId: verificationId,
              smsCode: _otpController.text.trim(),
              userData: userData,
            ).then((_) {
              Navigator.pop(context);
            });
          },
          child: Text("Verify & Create"),
        ),
      ],
    ),
  );
}
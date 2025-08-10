import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../providers/user_provider.dart';
import 'add_text_field.dart';
import 'back_button.dart';
import 'otp_dialog.dart';
import 'send_otp_button.dart';

class AddUserDialog extends StatefulWidget {
  @override
  State<AddUserDialog> createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _buildingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return AlertDialog(
      backgroundColor: Colors.white,
      title: Center(child: const Text("Add User")),
      content: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.45,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                AddTextField(
                  controller: _firstNameController,
                  validator: (value) =>
                  value == null || value.isEmpty ? 'First name is required' : null,
                  label: 'First Name',
                  hint: 'First Name',
                ),
                AddTextField(
                  controller: _lastNameController,
                  validator: (value) =>
                  value == null || value.isEmpty ? 'Last name is required' : null,
                  label: 'Last Name',
                  hint: 'Last Name',
                ),
                AddTextField(
                  controller: _usernameController,
                  validator: (value) =>
                  value == null || value.isEmpty ? 'Username is required' : null,
                  label: 'Username',
                  hint: 'Username',
                ),
                AddTextField(
                  controller: _phoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Phone number is required';
                    if (!RegExp(r'^\+63\d{10}$').hasMatch(value)) {
                      return 'Enter a valid +63 phone number';
                    }
                    return null;
                  },
                  label: 'Phone Number (+63)',
                  hint: "9XXXXXXXXX",
                  keyboardType: TextInputType.phone,
                ),
                AddTextField(
                  controller: _buildingController,
                  validator: (value) =>
                  value == null || value.isEmpty ? 'Building is required' : null,
                  label: 'Building',
                  hint: 'Building',
                ),
                Row(
                  children: [
                    BackButtonWidget(
                      onTap: () => Navigator.pop(context),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: SendOtpButton(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            final userData = {
                              "firstName": _firstNameController.text.trim(),
                              "lastName": _lastNameController.text.trim(),
                              "username": _usernameController.text.trim(),
                              "phoneNo": "+63" + _phoneController.text.trim(),
                              "building": _buildingController.text.trim(),
                              "role": "user",
                            };

                            userProvider.addUser(
                              phoneNumber: _phoneController.text.trim(),
                              userData: userData,
                              onCodeSent: (verificationId) {
                                Navigator.pop(context);
                                showOtpDialog(context, verificationId, userData);
                              },
                              onError: (err) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(content: Text(err)));
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

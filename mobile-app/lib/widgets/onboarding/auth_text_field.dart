import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthTextField extends StatefulWidget {
  final String hint;
  final bool showToggle;
  final bool obscureText;
  final TextEditingController controller;
  final String type;

  const AuthTextField({
    super.key,
    required this.hint,
    required this.controller,
    required this.type,
    this.showToggle = false,
    this.obscureText = false,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final String countryCode = "+63";

    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 2, color: Colors.white),
      ),
      child: TextField(
        controller: widget.controller,
        obscureText: _obscure,
        style: const TextStyle(color: Colors.white),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          prefix: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Text(
              widget.type == "phone" ? countryCode : "",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          hintText: widget.hint,
          hintStyle: const TextStyle(color: Colors.white54),
          suffixIcon: widget.showToggle
              ? IconButton(
            onPressed: () {
              setState(() {
                _obscure = !_obscure;
              });
            },
            icon: Icon(
              _obscure
                  ? Icons.remove_red_eye_outlined
                  : Icons.remove_red_eye,
              color: Colors.white,
            ),
          )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
        keyboardType: TextInputType.phone,
      ),
    );
  }
}

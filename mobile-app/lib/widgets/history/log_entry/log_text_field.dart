import 'package:flutter/material.dart';

class LogTextField extends StatefulWidget {
  final TextEditingController controller;
  const LogTextField({super.key, required this.controller});

  @override
  State<LogTextField> createState() => _LogTextFieldState();
}

class _LogTextFieldState extends State<LogTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      expands: true,
      maxLines: null,
      minLines: null,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        hintText: 'Share your thoughts, experiences, or notes.',
        hintStyle: TextStyle(
          color: Colors.grey
        ),
        border: OutlineInputBorder(
          // Ensures no underline
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

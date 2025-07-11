import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  final String title;
  final bool showToggle;
  final bool obscureText;

  const AuthTextField(
      {super.key,
      required this.title,
      this.showToggle = false,
      this.obscureText = false});

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
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 2, color: Colors.white),
      ),
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: TextField(
          obscureText: _obscure,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.white),
            labelText: widget.title,
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
            floatingLabelBehavior: FloatingLabelBehavior.never,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          ),
        ),
      ),
    );
  }
}

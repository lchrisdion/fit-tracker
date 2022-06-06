import 'package:flutter/material.dart';

class GlobalTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final Function(String)? onSubmit;
  final String hintText;
  final bool isPassword;
  final TextInputType? keyboardType;
  final TextInputAction? inputAction;
  final IconData prefixIcon;
  const GlobalTextField({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.hintText,
    required this.prefixIcon,
    this.keyboardType,
    this.inputAction,
    this.isPassword: false,
    this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 49,
      margin: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      width: double.infinity,
      child: TextField(
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        obscureText: isPassword,
        keyboardType: keyboardType ??
            (isPassword ? TextInputType.visiblePassword : TextInputType.text),
        textInputAction: inputAction,
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.zero,
          prefixIcon: Padding(
            padding: EdgeInsets.all(14),
            child: Icon(
              prefixIcon,
              color: Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 14, color: Colors.grey),
        ),
        onChanged: onChanged,
        onSubmitted: onSubmit,
      ),
    );
  }
}

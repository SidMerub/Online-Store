import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String hintText;
  final String labelText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const CustomTextFormField({
     this.controller,
     required this.keyboardType,
    required this.hintText,
    required this.labelText,
    this.obscureText = false,
     this.validator,
     this.prefixIcon, // Make prefix icon required
    this.suffixIcon, // Make suffix icon optional
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        hintText: hintText,
        labelText: labelText,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.pink),
             borderRadius: BorderRadius.all(Radius.circular(20.0))
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(20.0))
        ),
        suffixIcon: suffixIcon, // Use suffix icon if provided
      ),
      validator: validator,
    );
  }
}


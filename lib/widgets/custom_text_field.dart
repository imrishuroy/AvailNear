import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Function(String value) onChanged;
  final TextInputType textInputType;
  final String? Function(String? value) validator;
  final String hintText;
  final IconData? prefixIcon;
  final bool isPassowrdField;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final String? initialValue;
  final String? labelText;
  final int? maxLines;
  final TextEditingController? controller;

  const CustomTextField({
    Key? key,
    required this.onChanged,
    required this.textInputType,
    required this.validator,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassowrdField = false,
    this.contentPadding = const EdgeInsets.fromLTRB(12, 8, 12, 8),
    this.initialValue,
    this.labelText,
    this.maxLines,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        initialValue: initialValue,
        style: const TextStyle(color: Colors.black, fontSize: 16.0),
        onChanged: onChanged,
        keyboardType: textInputType,
        validator: validator,
        obscureText: isPassowrdField,
        decoration: InputDecoration(
          labelText: labelText,

          contentPadding: contentPadding,
          //fillColor: const Color(0xff262626),
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          prefixIcon:
              prefixIcon != null ? Icon(prefixIcon, color: Colors.grey) : null,
          suffixIcon: suffixIcon,
          labelStyle: const TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat',
            fontSize: 14.0,
            letterSpacing: 1.0,
          ),
          hintText: hintText,

          // hintStyle: const TextStyle(color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}

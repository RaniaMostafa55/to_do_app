import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final TextEditingController controller;
  String message;
  String hint;
  IconData icon;
  VoidCallback? onTap;
  TextInputType type;

  DefaultTextField(
      {super.key,
      required this.controller,
      required this.message,
      required this.hint,
      required this.icon,
      this.onTap,
      required this.type});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: type,
      onTap: onTap,
      controller: controller,
      validator: ((value) {
        if (value!.isEmpty) {
          return message;
        }
        return null;
      }),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        hintText: hint,
        prefixIcon: Icon(icon),
      ),
    );
  }
}

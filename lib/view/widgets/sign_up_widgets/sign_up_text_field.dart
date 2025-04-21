import 'package:flutter/material.dart';

class SignUpTextField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final TextEditingController controller;
  final String? requiredMessage;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const SignUpTextField({
    super.key,
    required this.icon,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.requiredMessage,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator ??
            (value) =>
                (value == null || value.isEmpty) ? requiredMessage : null,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.red),
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TextFieldCustomWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final bool autofocus;
  final TextInputType type;
  TextFieldCustomWidget({
    Key? key,
    required this.controller,
    required this.hint,
    this.type = TextInputType.text,
    this.obscure = false,
    this.autofocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: this.controller,
      obscureText: this.obscure,
      keyboardType: this.type,
      autofocus: this.autofocus,
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          hintText: this.hint,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
          )),
    );
  }
}

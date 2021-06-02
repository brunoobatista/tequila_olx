import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class TextFormFieldCustomWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final bool obscure;
  final bool autofocus;
  final TextInputType type;
  final MultiValidator validator;
  final Function(String?)? onSaved;
  TextFormFieldCustomWidget({
    Key? key,
    required this.hint,
    required this.validator,
    this.controller,
    this.onSaved,
    this.type = TextInputType.text,
    this.obscure = false,
    this.autofocus = false,
  })  : assert(controller != null || onSaved != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: this.controller,
      validator: this.validator,
      onSaved: this.onSaved,
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

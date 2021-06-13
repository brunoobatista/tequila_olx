import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';

class TextFormFieldCustomWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final bool obscure;
  final bool autofocus;
  final TextInputType type;
  final FieldValidator validator;
  final Function(String?)? onSaved;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  TextFormFieldCustomWidget({
    Key? key,
    required this.hint,
    required this.validator,
    this.controller,
    this.onSaved,
    this.maxLines,
    this.inputFormatters,
    this.type = TextInputType.text,
    this.obscure = false,
    this.autofocus = false,
  })  : assert(controller != null || onSaved != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (this.obscure)
      return TextFormField(
        controller: this.controller,
        validator: this.validator,
        onSaved: this.onSaved,
        obscureText: this.obscure,
        keyboardType: this.type,
        autofocus: this.autofocus,
        style: TextStyle(fontSize: 20),
        inputFormatters: this.inputFormatters,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            hintText: this.hint,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            )),
      );
    else
      return TextFormField(
        controller: this.controller,
        validator: this.validator,
        onSaved: this.onSaved,
        obscureText: this.obscure,
        keyboardType: this.type,
        autofocus: this.autofocus,
        style: TextStyle(fontSize: 20),
        inputFormatters: this.inputFormatters,
        maxLines: this.maxLines,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            hintText: this.hint,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            )),
      );
  }
}

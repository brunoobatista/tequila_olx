import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:olx_tequila/core/AppPadding.dart';

class DropdownCustomWidget extends StatelessWidget {
  final List<DropdownMenuItem<dynamic>> menuItens;
  final dynamic currentValue;
  final FieldValidator validator;
  final Function(dynamic currentValue) onChange;
  final Function(dynamic currentValue) onSaved;
  final String hint;
  DropdownCustomWidget({
    Key? key,
    required this.hint,
    required this.menuItens,
    required this.currentValue,
    required this.onChange,
    required this.onSaved,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppPadding.all8),
      child: DropdownButtonFormField<dynamic>(
        hint: Text(this.hint),
        style: TextStyle(color: Colors.black, fontSize: 20),
        value: this.currentValue,
        items: this.menuItens,
        validator: this.validator,
        onChanged: (value) {
          this.onChange(value);
        },
        onSaved: (value) {
          this.onSaved(value);
        },
        isExpanded: true,
      ),
    );
  }
}

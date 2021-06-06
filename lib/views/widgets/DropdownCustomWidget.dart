import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:olx_tequila/core/AppPadding.dart';

class DropdownCustomWidget extends StatelessWidget {
  final List<DropdownMenuItem<dynamic>> menuItens;
  final dynamic currentValue;
  final FieldValidator validator;
  final Function(dynamic currentValue) onTap;
  final String hint;
  DropdownCustomWidget(
      {Key? key,
      required this.hint,
      required this.menuItens,
      required this.currentValue,
      required this.onTap,
      required this.validator})
      : super(key: key);

  _emptyValidation() {
    return null;
  }

  _executeFunction(value) {}

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(AppPadding.all8),
        child: DropdownButtonFormField<dynamic>(
          hint: Text(this.hint),
          value: this.currentValue,
          items: this.menuItens,
          validator: this.validator,
          // onTap: this.onTap,
          onChanged: (value) {
            this.onTap(value);
          },
        ),
      ),
    );
  }
}

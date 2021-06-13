import 'package:form_field_validator/form_field_validator.dart';

class RequiredValidatorCustomObject extends FieldValidator<String?> {
  RequiredValidatorCustomObject({required String errorText}) : super(errorText);

  String? call(Object? value) {
    return isValid(value) ? null : errorText;
  }

  @override
  bool isValid(Object? value) {
    return value != null ? true : false;
  }
}

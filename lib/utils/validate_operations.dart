import 'package:dms_dealers/utils/contants.dart';
import 'package:flutter/foundation.dart' show immutable;


@immutable
class ValidateOperations {
  const ValidateOperations._();

  static normalValidation(
    dynamic value,
  ) {
    if (value == null || value.isEmpty) {
      return Constants.requiredField;
    }
    return null;
  }

  static emailValidation(dynamic email) {
    bool emailValid =
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+").hasMatch(email);

    if (email == null || email.isEmpty || !emailValid) {
      return Constants.makeSureCorrectMail;
    }
    return null;
  }
}

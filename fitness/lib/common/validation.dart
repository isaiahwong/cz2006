import 'package:formz/formz.dart';

enum GenericTextValidationError {
  tooShort,
  tooLong,
}

class GenericText extends FormzInput<String, GenericTextValidationError> {
  const GenericText.pure() : super.pure('');
  const GenericText.dirty([String value = '']) : super.dirty(value);

  @override
  GenericTextValidationError? validator(String value) {
    if (value.length < 3) {
      return GenericTextValidationError.tooShort;
    }
    if (value.length > 30) {
      return GenericTextValidationError.tooLong;
    }
    return null;
  }
}

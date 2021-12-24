import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:interview/generated/locales.g.dart';

@lazySingleton
class ValidatorService {
  String? validateName(String? value) {
    /*if (isSubmitted) {
      return null;
    }*/

    var hasLettersNumbers = RegExp(r'^[A-Za-z0-9 _]*[A-Za-z0-9][A-Za-z0-9 _]*$').hasMatch(value!.trim());
    if (value == null || value.isEmpty) {
      return LocaleKeys.required.tr;
    } else if (!GetUtils.isLengthBetween(value, 4, 16)) {
      return LocaleKeys.input_length.trParams({
        'min': '4',
        'max': '16',
      });
    } else if (!hasLettersNumbers) {
      return LocaleKeys.only_letter_number.tr;
    }
    return null;
  }
}

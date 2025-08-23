import 'package:flutter/services.dart';

class FieldMasks {
  static List<TextInputFormatter> formatCpf() => [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(11),
    TextInputFormatter.withFunction((oldValue, newValue) {
      final text = newValue.text;
      if (text.length <= 3) {
        return newValue;
      } else if (text.length <= 6) {
        final newText = '${text.substring(0, 3)}.${text.substring(3)}';
        return newValue.copyWith(
          text: newText,
          selection: TextSelection.collapsed(offset: newText.length),
        );
      } else if (text.length <= 9) {
        final newText =
            '${text.substring(0, 3)}.${text.substring(3, 6)}.${text.substring(6)}';
        return newValue.copyWith(
          text: newText,
          selection: TextSelection.collapsed(offset: newText.length),
        );
      } else if (text.length <= 11) {
        final newText =
            '${text.substring(0, 3)}.${text.substring(3, 6)}.${text.substring(6, 9)}-${text.substring(9)}';
        return newValue.copyWith(
          text: newText,
          selection: TextSelection.collapsed(offset: newText.length),
        );
      }
      return oldValue;
    }),
  ];

  static List<TextInputFormatter> formatPhoneNumber() => [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(11),
    TextInputFormatter.withFunction((oldValue, newValue) {
      final text = newValue.text;
      if (text.length <= 2) {
        return newValue;
      } else if (text.length <= 6) {
        final newText = '(${text.substring(0, 2)}) ${text.substring(2)}';
        return newValue.copyWith(
          text: newText,
          selection: TextSelection.collapsed(offset: newText.length),
        );
      } else if (text.length <= 10) {
        final newText =
            '(${text.substring(0, 2)}) ${text.substring(2, 6)}-${text.substring(6)}';
        return newValue.copyWith(
          text: newText,
          selection: TextSelection.collapsed(offset: newText.length),
        );
      } else if (text.length <= 11) {
        final newText =
            '(${text.substring(0, 2)}) ${text.substring(2, 7)}-${text.substring(7)}';
        return newValue.copyWith(
          text: newText,
          selection: TextSelection.collapsed(offset: newText.length),
        );
      }
      return oldValue;
    }),
  ];

  static List<TextInputFormatter> formatCnpj() => [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(14),
    TextInputFormatter.withFunction((oldValue, newValue) {
      final text = newValue.text;
      if (text.length <= 2) {
        return newValue;
      } else if (text.length <= 5) {
        final newText = '${text.substring(0, 2)}.${text.substring(2)}';
        return newValue.copyWith(
          text: newText,
          selection: TextSelection.collapsed(offset: newText.length),
        );
      } else if (text.length <= 8) {
        final newText =
            '${text.substring(0, 2)}.${text.substring(2, 5)}.${text.substring(5)}';
        return newValue.copyWith(
          text: newText,
          selection: TextSelection.collapsed(offset: newText.length),
        );
      } else if (text.length <= 12) {
        final newText =
            '${text.substring(0, 2)}.${text.substring(2, 5)}.${text.substring(5, 8)}/${text.substring(8)}';
        return newValue.copyWith(
          text: newText,
          selection: TextSelection.collapsed(offset: newText.length),
        );
      } else if (text.length <= 14) {
        final newText =
            '${text.substring(0, 2)}.${text.substring(2, 5)}.${text.substring(5, 8)}/${text.substring(8, 12)}-${text.substring(12)}';
        return newValue.copyWith(
          text: newText,
          selection: TextSelection.collapsed(offset: newText.length),
        );
      }
      return oldValue;
    }),
  ];

  static List<TextInputFormatter> formatEmail() => [
    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._-]')),
    LengthLimitingTextInputFormatter(100),
  ];
}

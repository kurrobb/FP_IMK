import 'package:flutter/services.dart';

/// Formats account number input into groups of 4 digits separated by spaces
/// Example: "1234567890123456" -> "1234 5678 9012 3456"
class AccountNumberFormatter extends TextInputFormatter {
  final int groupSize;
  final int maxGroups;

  AccountNumberFormatter({
    this.groupSize = 4,
    this.maxGroups = 3,
  });

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Only allow digits
    final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Limit to max digits (groupSize * maxGroups)
    final maxLength = groupSize * maxGroups;
    final limitedDigits = digitsOnly.length > maxLength
        ? digitsOnly.substring(0, maxLength)
        : digitsOnly;

    // Format into groups
    final buffer = StringBuffer();
    for (int i = 0; i < limitedDigits.length; i++) {
      if (i > 0 && i % groupSize == 0) {
        buffer.write(' ');
      }
      buffer.write(limitedDigits[i]);
    }

    final formattedText = buffer.toString();
    
    // Calculate cursor position
    // Keep cursor after the last character (or after a space if at group boundary)
    int cursorOffset = formattedText.length;

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: cursorOffset),
    );
  }
}

/// Formats phone number input into groups of 4 digits separated by spaces (3x4 format)
/// Example: "081578979853" -> "0815 7897 9853"
class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Only allow digits
    final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Limit to 12 digits (3 groups of 4)
    final maxLength = 12;
    final limitedDigits = digitsOnly.length > maxLength
        ? digitsOnly.substring(0, maxLength)
        : digitsOnly;

    // Format into 3 groups of 4 digits
    final buffer = StringBuffer();
    for (int i = 0; i < limitedDigits.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(limitedDigits[i]);
    }

    final formattedText = buffer.toString();
    
    // Calculate cursor position
    int cursorOffset = formattedText.length;

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: cursorOffset),
    );
  }
}

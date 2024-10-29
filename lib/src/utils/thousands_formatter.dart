import 'package:flutter/services.dart';

class ThousandsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final int selectionIndex = newValue.selection.end;
    String newText = newValue.text.replaceAll('.', '');

    int newSelectionIndex = selectionIndex;
    for (var i = 0; i < newText.length - 1; i++) {
      if (i % 4 == 0) newSelectionIndex++;
    }

    // Add the thousands separators
    newText = newText.replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match match) => '${match[1]}.',
    );

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newSelectionIndex),
    );
  }
}

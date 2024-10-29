import 'package:flutter/material.dart';

Widget customSnackBar(BuildContext context, String message) {
  return SnackBar(
    content: Text(message),
    duration: const Duration(seconds: 5),
  );
}

import 'package:flutter/material.dart';

class CustomTextStyles {
  static TextStyle headingTextStyle(BuildContext context) {
    return TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontWeight:FontWeight.w500,
        fontSize: 20
    );
  }

  static TextStyle paragraphTextStyle(BuildContext context) {
    return TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight:FontWeight.w400,
            fontSize: 16
    );
  }
  static TextStyle categoryTextStyle(BuildContext context) {
    return TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontWeight:FontWeight.w400,
        fontSize: 12
    );
  }

}


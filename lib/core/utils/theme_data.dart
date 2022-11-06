import 'package:flutter/material.dart';

class AppThemeData {
  AppThemeData._();

  static final appTheme = ThemeData(
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 0.0,
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 0.0,
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
      ));
}

import 'package:flutter/material.dart';
import 'package:interview_app/themes/colors.dart';

final class ThemeApp {
  ThemeData get theme {
    return ThemeData(fontFamily: 'Quicksand', useMaterial3: true).copyWith(
      // scaffoldBackgroundColor: Colors.amber, // Màu nền
      // outlinedButtonTheme: OutlinedButtonThemeData(
      //   style: OutlinedButton.styleFrom(foregroundColor: colors.primary),
      // ),
      // filledButtonTheme: FilledButtonThemeData(
      //   style: FilledButton.styleFrom(backgroundColor: colors.primary),
      // ),
      // elevatedButtonTheme: ElevatedButtonThemeData(
      //   style: ElevatedButton.styleFrom(foregroundColor: colors.primary),
      // ),
      // textButtonTheme: TextButtonThemeData(
      //   style: TextButton.styleFrom(foregroundColor: colors.primary),
      // ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorsApp.primary,
        primary: ColorsApp.primary,
      ),
    );
  }
}

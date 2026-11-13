import 'package:flutter/material.dart';

import 'theme_colors.dart';

abstract final class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ThemeColors.accent,
      primary: ThemeColors.accent,
      secondary: ThemeColors.lime,
      surface: ThemeColors.background,
    ),
    scaffoldBackgroundColor: ThemeColors.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: ThemeColors.accent,
      foregroundColor: ThemeColors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      toolbarHeight: 64,
      titleTextStyle: TextStyle(
        fontSize: 23,
        color: ThemeColors.white,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

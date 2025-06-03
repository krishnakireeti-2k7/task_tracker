import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppThemeModes { light, dark }

final appThemes = {
  AppThemeModes.light: ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(0xFF80B680),
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: Colors.grey[50],
    appBarTheme: AppBarTheme(backgroundColor: Color(0xFF80B680)),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF80B680),
    ),
    inputDecorationTheme: InputDecorationTheme(border: OutlineInputBorder()),
  ),
  AppThemeModes.dark: ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(backgroundColor: Colors.blue[400]),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.blue[400],
    ),
    inputDecorationTheme: InputDecorationTheme(border: OutlineInputBorder()),
  ),
};
final themeProvider = StateProvider<AppThemeModes>((ref) {
  return AppThemeModes.dark;
});

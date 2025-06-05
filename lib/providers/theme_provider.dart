import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppThemeModes { light, dark }

final appThemes = {
  AppThemeModes.light: ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(0xFF80B680),
      brightness: Brightness.light,
      surface: Color(0xFFECEFF1),
    ),
    cardColor: Color(0xFFECEFF1), 
    scaffoldBackgroundColor: Color(0xFFF5F3EF),
    appBarTheme: AppBarTheme(backgroundColor: Color(0xFFE4E0DA)),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFA3BCE2),
    ),
    inputDecorationTheme: InputDecorationTheme(border: OutlineInputBorder()),
  ),
  AppThemeModes.dark: ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
      surface: Colors.blueGrey,
    ),
    cardColor: Colors.blueGrey,
    scaffoldBackgroundColor: Color(0xFF222827),
    appBarTheme: AppBarTheme(backgroundColor: Color.fromARGB(255, 90, 58, 21)),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.blueGrey,
    ),
    inputDecorationTheme: InputDecorationTheme(border: OutlineInputBorder()),
  ),
};
final themeProvider = StateProvider<AppThemeModes>((ref) {
  return AppThemeModes.light;
});

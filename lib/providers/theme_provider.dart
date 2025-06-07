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
    bottomAppBarTheme: BottomAppBarTheme(
      color: Color(0xFFE4E0DA),
      elevation: 8,
      shape: CircularNotchedRectangle(),
    ),
    cardColor: Color(0xFFECEFF1),
    scaffoldBackgroundColor: Color(0xFFF5F3EF),
    appBarTheme: AppBarTheme(backgroundColor: Color(0xFFE4E0DA)),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: CircleBorder(),
      backgroundColor: Color(0xFFA3BCE2),
    ),
    inputDecorationTheme: InputDecorationTheme(border: OutlineInputBorder()),
  ),
  AppThemeModes.dark: ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(0xFF80B680), // matching greenish-gray accent
      brightness: Brightness.dark,
      surface: Color(0xFF1E1E1E),
    ),
    scaffoldBackgroundColor: Color(0xFF181A1B), // deep matte gray
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF2B2B2B),
      foregroundColor: Colors.white,
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.5),
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: Color(0xFF2B2B2B),
      elevation: 8,
      shape: CircularNotchedRectangle(),
      shadowColor: Colors.black.withOpacity(0.5),
    ),
    cardColor: Color(
      0xFF222527,
    ), // soft card background, lifted slightly from scaffold
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: CircleBorder(),
      backgroundColor: Color(0xFF80B680), // muted green accent
      foregroundColor: Colors.black,
      elevation: 6,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFF2D2D2D),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF80B680)),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF80B680), width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      hintStyle: TextStyle(color: Colors.grey[400]),
      labelStyle: TextStyle(color: Color(0xFF80B680)),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
      bodyMedium: TextStyle(color: Color(0xFFCCCCCC), fontSize: 14),
      labelLarge: TextStyle(color: Color(0xFF80B680)),
    ),
  )

};
final themeProvider = StateProvider<AppThemeModes>((ref) {
  return AppThemeModes.light;
});

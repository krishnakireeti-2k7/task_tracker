import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppThemeModes { light, dark }
const lightBackgroundGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFFF5F3EF), // Your scaffold background (creamy off-white)
    Color(0xFFE4E0DA), // Bottom app bar background
    Color(0xFFDCE9F4), // Pale blue-lavender (from your seedColor)
  ],
);

const darkBackgroundGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFF181A1B), // Scaffold background
    Color(0xFF1E1E1E), // Surface
    Color(0xFF2A2D2E), // Input fill color
  ],
);

final appThemes = {
  AppThemeModes.light: ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(0xFFA3BCE2),
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
    dialogTheme: DialogTheme(
      backgroundColor: Color(0xFFECEFF1), // match your cardColor
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      contentTextStyle: TextStyle(fontSize: 16, color: Colors.black87),
    ),

    inputDecorationTheme: InputDecorationTheme(border: OutlineInputBorder()),
  ),
  AppThemeModes.dark: ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
      primary: Color(0xFFEBAAA3), // warm amber accent
      secondary: Color(0xFF92400E), // deeper amber/brown
      background: Color(0xFF181A1B),
      surface: Color(0xFF1E1E1E),
      onPrimary: Colors.black,
      onSurface: Colors.white70,
    ),
    scaffoldBackgroundColor: Color(0xFF181A1B),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF1F1F1F),
      foregroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: Color(0xFF1F1F1F),
      elevation: 6,
      shape: CircularNotchedRectangle(),
    ),
    cardColor: Color(0xFF222527),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: CircleBorder(),
      backgroundColor: Color(0xFF38BDF8), // warm subtle orange
      foregroundColor: Colors.black,
      elevation: 6,
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Color(0xFF222527),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      contentTextStyle: TextStyle(fontSize: 16, color: Colors.white70),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFF2A2D2E),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF92400E)), // muted accent border
        borderRadius: BorderRadius.circular(10),
      ),
    ))
};
final themeProvider = StateProvider<AppThemeModes>((ref) {
  return AppThemeModes.light;
});

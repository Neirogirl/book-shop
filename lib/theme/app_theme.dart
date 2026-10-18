import 'package:flutter/material.dart';

class AppTheme {
  static const Color background = Color(0xFFFFF7E0);
  static const Color primary = Color(0xFF4A2C17);
  static const Color searchBar = Color(0xFFD9C9A8);
  static const Color accent = Color(0xFF6B7D3A);
  static const Color textDark = Color(0xFF3E2723);
  static const Color placeholder = Color(0xFFD3D3D3);

  static ThemeData get theme => ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: background,
        primaryColor: primary,
        appBarTheme: const AppBarTheme(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: primary,
          // Активный таб — оливковый
          selectedItemColor: accent,
          // Неактивные — полупрозрачный белый
          unselectedItemColor: Colors.white70,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
          unselectedLabelStyle: TextStyle(fontSize: 11),
          type: BottomNavigationBarType.fixed,
        ),
      );
}
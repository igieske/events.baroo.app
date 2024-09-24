import 'package:flutter/material.dart';

ThemeData appThemeDark = ThemeData(
  useMaterial3: true,

  colorScheme: const ColorScheme(
    brightness: Brightness.light,

    // фон
    surface: Color(0xfff9f7f7),
    // текст на фоне
    onSurface: Color(0xFF222222),
    // ссылки
    primary: Color(0xFF168ACD),
    onPrimary: Colors.white,
    // второстепенный
    secondary: Color(0xFFA0ACB6),
    onSecondary: Colors.white,

    error: Colors.purple,
    onError: Colors.pink,
  ),

);
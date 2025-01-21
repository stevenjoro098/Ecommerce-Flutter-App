import 'package:flutter/material.dart';

ThemeData ShopThemeData = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreenAccent),
    primaryColor: Colors.lightGreenAccent,
    useMaterial3: true,
    fontFamily: 'Poppins',
    elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
          backgroundColor: Colors.greenAccent,
          foregroundColor: Colors.white,
                    ),
            ),
    );
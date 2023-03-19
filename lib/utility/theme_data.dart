import 'package:flutter/material.dart';

ThemeData lightTheme() {
  return ThemeData(
    primaryColor: Colors.white,
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.blue,
      textTheme: ButtonTextTheme.primary,
    ),
    appBarTheme: const AppBarTheme(
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 27, fontWeight: FontWeight.bold)
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: Colors.blueAccent,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      displayMedium: TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.black,
    ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.blueAccent, brightness: Brightness.light),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Colors.blue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    ),
  );
}

ThemeData darkTheme() {
  return ThemeData(
    primaryColor: const Color(0xFF121212),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.orange,
      textTheme: ButtonTextTheme.primary,
    ),
    appBarTheme: const AppBarTheme(
      foregroundColor: Colors.orange,
      backgroundColor: Color(0xFF121212),
      titleTextStyle: TextStyle(color: Colors.orange, fontSize: 27, fontWeight: FontWeight.bold)
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color(0xFF121212),
    ),
    textTheme:  TextTheme(
      displayLarge: TextStyle(
        color: Colors.orange,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      displayMedium: TextStyle(
        color: Colors.white,
        fontSize: 14),
    ),
    iconTheme: const IconThemeData(
      color: Colors.orange,
    ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.orange, brightness: Brightness.dark),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Colors.orange,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    ),
  );
}

import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // Primary color for the app
    primaryColor: const Color(0xff07DEA3),
    scaffoldBackgroundColor: Colors.white, // Background color for scaffolds
    fontFamily: 'Monstserrat', // Default font family

    // Elevated button styling
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          fontSize: 16,
          color: Colors.white, // Text color for buttons
          fontWeight: FontWeight.bold,
          fontFamily: 'Monstserrat',
        ),
        backgroundColor: const Color(0xff07DEA3), // Button background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5), // Rounded corners
        ),
      ),
    ),

    // App bar styling
    appBarTheme: const AppBarTheme(
      centerTitle: true, // Center-align the title
      color: Color(0xff07DEA3), // AppBar background color
      elevation: 4, // AppBar shadow elevation
      shadowColor: Colors.black, // Shadow color
      titleTextStyle: TextStyle(
        fontSize: 20, // Title text size
        color: Colors.white, // Title text color
        fontWeight: FontWeight.bold, // Title text weight
        fontFamily: 'Monstserrat Bold', // Title font family
      ),
    ),

    // Input field styling
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white, // Input field background color
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8), // Rounded corners for inputs
        borderSide: const BorderSide(
          color: Color(0xff07DEA3), // Border color
          width: 2,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color(0xff07DEA3), // Enabled border color
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color(0xff07DEA3), // Focused border color
          width: 2,
        ),
      ),
      hintStyle: const TextStyle(
        color: Colors.black45, // Hint text color
      ),
      labelStyle: const TextStyle(
        color: Colors.black54, // Label text color
      ),
    ),

    // Text theme for various components
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xff3454A4), // Title text color
        fontFamily: 'Monstserrat',
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white, // Button text color
        fontFamily: 'Monstserrat',
      ),
    ),
  );
}

import 'package:flutter/material.dart';

ThemeData getApplicationTheme({required bool isDarkMode}) {
  // Common properties shared between light and dark themes
  const Color primaryColor = Color(0xff07DEA3); // Teal-like color
  final Color scaffoldBackgroundColor =
      isDarkMode ? Colors.grey[900]! : Colors.white;
  const String fontFamily = 'Monstserrat';

  return ThemeData(
    // Set brightness based on isDarkMode
    brightness: isDarkMode ? Brightness.dark : Brightness.light,

    // Primary color for the app
    primaryColor: primaryColor,

    // Background color for scaffolds
    scaffoldBackgroundColor: scaffoldBackgroundColor,

    // Default font family
    fontFamily: fontFamily,

    // Elevated button styling
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          fontSize: 16,
          color: Colors.white, // Text color stays white for contrast
          fontWeight: FontWeight.bold,
          fontFamily: fontFamily,
        ),
        backgroundColor: primaryColor, // Button background stays consistent
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    ),

    // App bar styling
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: primaryColor, // AppBar stays teal
      elevation: 4,
      shadowColor: isDarkMode
          ? Colors.black
          : Colors.grey[800], // Adjust shadow for dark mode
      titleTextStyle: const TextStyle(
        fontSize: 20,
        color: Colors.white, // White text for contrast
        fontWeight: FontWeight.bold,
        fontFamily: 'Monstserrat Bold',
      ),
    ),

    // Input field styling
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: isDarkMode
          ? Colors.grey[800]
          : Colors.white, // Dark grey for dark mode
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: primaryColor,
          width: 2,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: isDarkMode
              ? Colors.grey[600]!
              : primaryColor, // Softer border in dark mode
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: primaryColor, // Highlighted in teal when focused
          width: 2,
        ),
      ),
      hintStyle: TextStyle(
        color: isDarkMode
            ? Colors.grey[400]
            : Colors.black45, // Lighter hint in dark mode
      ),
      labelStyle: TextStyle(
        color: isDarkMode
            ? Colors.grey[300]
            : Colors.black54, // Lighter label in dark mode
      ),
    ),

    // Text theme for various components
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: isDarkMode
            ? Colors.white
            : const Color(0xff3454A4), // White in dark mode
        fontFamily: fontFamily,
      ),
      labelLarge: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white, // Button text stays white
        fontFamily: fontFamily,
      ),
    ),

    // Additional adjustments for dark mode
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.teal, // Matches your primaryColor
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      backgroundColor: scaffoldBackgroundColor,
    ).copyWith(
      surface:
          isDarkMode ? Colors.grey[850] : Colors.white, // Surface (cards, etc.)
      onSurface:
          isDarkMode ? Colors.white : Colors.black, // Text/icons on surfaces
    ),
  );
}

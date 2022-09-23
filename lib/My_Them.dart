import 'package:flutter/material.dart';

class MyThem {
  static final Color lightPrimary = Color(0xFF5D9CEC);
  static final Color lightScafoldBackground = Color(0xFFDFECDB);
  static final Color darkScafoldBackground = Color(0xFF060E1E);

  static final Color geren = Color(0xFF61E757);
  static final Color red = Color(0xFFEC4B4B);

  static final ThemeData light_them = ThemeData(
      primaryColor: lightPrimary,
      scaffoldBackgroundColor: lightScafoldBackground,
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        // backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.w500,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedIconTheme: IconThemeData(
            size: 33, // خصائص الايقون
            color: Colors.green),
        unselectedIconTheme: IconThemeData(size: 33, color: Colors.red),
        // selectedItemColor: Colors.black, // لون الكلام
        // unselectedItemColor: Colors.white,
      ),
      textTheme: TextTheme(
        // هنا لو عايز احط خصائص للخط عشان ابقي اعدلها فى الدارك
        titleMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: lightPrimary,
        ),
        titleSmall: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        bodySmall: const TextStyle(
          fontSize: 12,
          color: Colors.black,
        ),
      ));



  static final ThemeData Dark_them = ThemeData(
      primaryColor: lightPrimary,
      scaffoldBackgroundColor: darkScafoldBackground,
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        // backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.w500,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedIconTheme: IconThemeData(
            size: 33, // خصائص الايقون
            color: Colors.green),
        unselectedIconTheme: IconThemeData(size: 33, color: Colors.red),
        // selectedItemColor: Colors.black, // لون الكلام
        // unselectedItemColor: Colors.white,
      ),
      textTheme: TextTheme(
        // هنا لو عايز احط خصائص للخط عشان ابقي اعدلها فى الدارك
        titleMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: lightPrimary,
        ),
        titleSmall: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        bodySmall: const TextStyle(
          fontSize: 12,
          color: Colors.white,
        ),
      ));
}

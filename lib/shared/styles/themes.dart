import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/shared/styles/colors.dart';


ThemeData lightTheme= ThemeData(
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white30,
      statusBarIconBrightness: Brightness.dark,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    // backgroundColor: Colors.white,
    elevation: 0.0,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: kDefaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
      bodyText1: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    subtitle1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
  ),
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  primarySwatch: Colors.deepOrange,
);


ThemeData darkTheme= ThemeData(
  scaffoldBackgroundColor: const Color(0xFF333739),
  appBarTheme: const AppBarTheme(
    titleSpacing: 20,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color(0xFF333739),
      statusBarIconBrightness: Brightness.light,
    ),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    backgroundColor: Color(0xFF333739),
    elevation: 0.0,
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: kDefaultColor,
      unselectedItemColor: Colors.grey,
      elevation: 20.0,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0xFF333739)
  ),
  textTheme: const TextTheme(
      bodyText1: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      )
  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  primarySwatch: Colors.deepOrange,
);
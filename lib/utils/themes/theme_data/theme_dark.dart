import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invoice_saver/utils/app_colors.dart';

ThemeData themeDark = ThemeData(
  scaffoldBackgroundColor: Colors.black26,
  brightness: Brightness.dark,
  primaryColorDark: Colors.blue,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black26,
    elevation: 0.0,
    titleTextStyle: GoogleFonts.poppins(
      color: AppColors.white,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    actionsIconTheme: const IconThemeData(color: AppColors.white, size: 26),
    toolbarTextStyle: GoogleFonts.poppins(
      color: AppColors.white,
      fontSize: 18,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.white,
    ),
  ),
  iconTheme: const IconThemeData(
    color: AppColors.white,
  ),
  textTheme: TextTheme(
    bodyMedium: GoogleFonts.poppins(
        color: AppColors.white, fontSize: 16, fontWeight: FontWeight.w500),
  ),
  tabBarTheme: const TabBarTheme(
    unselectedLabelColor: AppColors.grey,
    labelColor: AppColors.white,
  ),
  textButtonTheme: const TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStatePropertyAll<Color>(Colors.white),
    ),
  ),
);

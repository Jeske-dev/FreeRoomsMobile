import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme = ThemeData(
  primarySwatch: Colors.deepPurple,
  textTheme: GoogleFonts.ubuntuTextTheme().copyWith(
    labelMedium: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500
    ),
    labelSmall: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500
    ),
    labelLarge: const TextStyle(
      fontSize: 64,
      fontWeight: FontWeight.w400
    ),
  ),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: SharedAxisPageTransitionsBuilder(transitionType: SharedAxisTransitionType.horizontal, fillColor: Color(0xFF212121))
    }
  ),
  backgroundColor: Colors.grey[900]
);
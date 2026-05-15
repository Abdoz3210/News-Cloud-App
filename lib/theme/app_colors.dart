import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  //--Primary--------------------------------------
  static const Color primary = Color(0xFF835400);
  static const Color primaryLight = Color(0xFFF9A825);
  static const Color onPrimary = Color(0xFFFFFFFF);
  //--Surfaces (Light) ----------------------------
  static const Color surface = Color(0xfffcf9f8);
  static const Color surfaceContainerLow = Color(0xfff3efed);
  static const Color surfaceContainerHigh = Color(0xffe8e3e0);
  static const Color surfaceContianerHighest = Color(0xffddd8d5);
  //--Neutrals-------------------------------------
  static const Color deepNeutral = Color(0xff1c1b1b);
  static const Color onSurface = Color(0xff1c1b1b);
  static const Color onSurfaceVariant = Color(0xff6b6563);
  //--semantic-------------------------------------
  static const Color error = Color(0xffba1a1a);
  static const Color onError = Color(0xffffffff);

  //--Gradients------------------------------------
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.centerLeft,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient imageFadeGranient = LinearGradient(
    colors: [Colors.transparent, Color(0xcc1c1b1b)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  //-----Surfanes----------------------------------------------
  static const Color surfaceDark = Color(0xff1c1b1b);
  static const Color surfaceContainerLowDark = Color(0xff252323);
  static const Color surfaceContinerHighDark = Color(0xff2e2c2);
  static const Color surfaceContainerHighestDark = Color(0xff383535);

  //----Neutrals (Dark) ----------------------------------------
  static const Color onSurfaceDark = Color(0xfff3efed);
  static const Color onSurfaceVarianDark = Color(0xffada8a6);
  
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  //--Newsreader (Serif) --Headlines & Editorial------------
  static TextStyle get displayLg => GoogleFonts.newsreader(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    height: 1.15,
    // color: AppColors.deepNeutral,
  );

  static TextStyle get displayMd => GoogleFonts.newsreader(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    height: 1.2,
    // color: AppColors.deepNeutral,
  );

  static TextStyle get headline => GoogleFonts.newsreader(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.3,
    // color: AppColors.,
  );
  static TextStyle get headlineColor => GoogleFonts.newsreader(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: AppColors.primary,
  );

  static TextStyle get pullQuote => GoogleFonts.newsreader(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    height: 1.5,
    // color: AppColors.deepNeutral,
  );

  static TextStyle get bodySerif => GoogleFonts.newsreader(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    height: 1.7,
    // color: AppColors.deepNeutral,
  );

  //--Work Sans (Sans-serif)---UIU & Metadata -----------------

  static TextStyle get titleLg => GoogleFonts.workSans(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.3,
    // color: AppColors.deepNeutral,
  );
  static TextStyle get titleMd => GoogleFonts.workSans(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.4,
    // color: AppColors.deepNeutral,
  );

  static TextStyle get body => GoogleFonts.workSans(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.4,
    // color: AppColors.deepNeutral,
  );
  static TextStyle get labelLg => GoogleFonts.workSans(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    height: 1.4,
    // color: AppColors.deepNeutral,
  );
  static TextStyle get labelMd => GoogleFonts.workSans(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.4,
    // color: AppColors.deepNeutral,
  );
  static TextStyle get categoryTag => GoogleFonts.workSans(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    height: 0.10,
    // color: AppColors.deepNeutral,
  ).copyWith();
  static TextStyle get buttonLabel => GoogleFonts.workSans(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 0.04,
    // color: AppColors.onPrimary,
  );
  static TextStyle get caption => GoogleFonts.workSans(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    // height: 1.3,
    // color: AppColors.onSurfaceVariant,
  );
}

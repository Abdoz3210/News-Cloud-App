import 'package:flutter/material.dart';
import 'package:news_app/theme/typography.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
    useMaterial3: true, //  ???
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
      error: AppColors.error,
      onError: AppColors.onError,
      secondary: AppColors.primaryLight,
      onSecondary: AppColors.onPrimary,
      surfaceContainerLow: AppColors.surfaceContainerLow,
      surfaceContainerHigh: AppColors.surfaceContainerHigh,
      surfaceContainerHighest: AppColors.surfaceContianerHighest,
      onSurfaceVariant: AppColors.onSurfaceVariant,
    ),
    scaffoldBackgroundColor: AppColors.surface,
    dividerColor: Colors.transparent,
    //--Text theme --------------------------------------
    textTheme: TextTheme(
      displayLarge: AppTypography.displayLg,
      displayMedium: AppTypography.displayMd,
      headlineLarge: AppTypography.headline,
      titleLarge: AppTypography.titleLg,
      titleMedium: AppTypography.titleMd,
      bodyLarge: AppTypography.bodySerif,
      bodyMedium: AppTypography.body,
      labelLarge: AppTypography.labelLg,
      labelMedium: AppTypography.labelMd,
      labelSmall: AppTypography.caption,
    ),
  );
}

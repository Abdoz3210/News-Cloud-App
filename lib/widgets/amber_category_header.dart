import 'package:flutter/material.dart';
import 'package:news_app/theme/app_colors.dart';
import 'package:news_app/theme/typography.dart';

class AmberCategoryHeader extends StatelessWidget
    implements PreferredSizeWidget {
  const AmberCategoryHeader({super.key, required this.title});
  final String title;

  @override
  // Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      title: Text(
        title.toUpperCase(),
        style: AppTypography.titleLg.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.04,
        ),
      ),
      centerTitle: false,
    );
  }
}

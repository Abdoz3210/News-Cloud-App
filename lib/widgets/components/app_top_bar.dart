import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:news_app/theme/typography.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTopBar({super.key, required this.title, this.leading, this.actions});
  final String title;
  final Widget? leading;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 25),
        child: AppBar(
          title: Text(title, style: AppTypography.titleLg),
          leading: leading,
          actions: actions,
          backgroundColor: Theme.of(
            context,
          ).colorScheme.surface.withValues(alpha: 0.5),
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:news_app/core/constants/news_categories.dart';
import 'package:news_app/theme/app_colors.dart';
import 'package:news_app/theme/typography.dart';
import 'package:news_app/core/providers/auth_provider.dart';
import 'package:news_app/views/category_view.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      width: MediaQuery.sizeOf(context).width * 0.75,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _UserSection(),

            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'THE ARCHIVE',
                style: AppTypography.categoryTag.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(height: 8),

            Expanded(
              child: CustomScrollView(
                scrollDirection: Axis.vertical,
                scrollBehavior: ScrollBehavior(),
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: NewsCategories.length,
                      (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: _DrawerItem(
                            icon: NewsCategories[index].icons!,
                            label: NewsCategories[index].label,
                            isActive: false,
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CategoryView(
                                    category: NewsCategories[index].apiValue,
                                    label: NewsCategories[index].label,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: _DrawerItem(
                      icon: Icons.bookmark_outline_rounded,
                      label: "Saved Stories",
                      isActive: false,
                      onTap: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'PREFERENCES',
                style: AppTypography.categoryTag.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ),

            const SizedBox(height: 8),

            _DrawerItem(
              icon: Icons.info_outline_rounded,
              label: 'About Us',
              onTap: () => Navigator.pop(context),
            ),

            _DrawerItem(
              icon: Icons.logout_rounded,
              label: 'Sign Out',
              isSigbOut: true,
              onTap: () {
                Navigator.pop(context);
                context.read<AuthProvider>().signOut();
              },
            ),

            const SizedBox(height: 16),
            // Padding( )
          ],
        ),
      ),
    );
  }
}

class _UserSection extends StatelessWidget {
  const _UserSection();
  // final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    final photoBase64 = context.watch<AuthProvider>().photoBase64;
    Uint8List? imageBytes;
    if (photoBase64 != null) {
      try {
        imageBytes = base64Decode(photoBase64);
      } catch (e) {
        imageBytes = null;
      }
    }
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.primaryGradient,
            ),
            child: CircleAvatar(
              radius: 32,
              backgroundColor: Colors.transparent,
              backgroundImage: imageBytes != null
                  ? MemoryImage(imageBytes)
                  : null,
              child: imageBytes != null
                  ? Icon(
                      Icons.person_rounded,
                      size: 32,
                      color: AppColors.onSurfaceVariant,
                    )
                  : null,
            ),
          ),

          const SizedBox(height: 12),
          Text(
            context.watch<AuthProvider>().displayName,
            style: AppTypography.titleLg,
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(99),
            ),
            child: Text(
              'PREMIUM SUBSCRIBER',
              style: AppTypography.caption.copyWith(color: AppColors.onPrimary),
            ),
          ),
          const SizedBox(height: 8),
          Text('DALIY EDITION  VOL. 42', style: AppTypography.caption),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
    this.isSigbOut = false,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isActive, isSigbOut;
  @override
  Widget build(BuildContext context) {
    final color = isSigbOut
        ? Colors.red
        : isActive
        ? AppColors.primary
        : null;
    return ListTile(
      splashColor: AppColors.primary,
      leading: Icon(icon, color: color),
      title: Text(label, style: AppTypography.titleMd.copyWith(color: color)),
      tileColor: isActive
          ? AppColors.primary.withValues(alpha: 0.1)
          : Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onTap: onTap,
    );
  }
}

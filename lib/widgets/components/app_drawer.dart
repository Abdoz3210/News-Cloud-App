import 'dart:io';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/theme/app_colors.dart';
import 'package:news_app/theme/typography.dart';
import 'package:news_app/core/providers/auth_provider.dart';
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
            _userSection(),

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

            _DrawerItem(
              icon: Icons.public_rounded,
              label: "World News",
              isActive: true,
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(height: 8),
            _DrawerItem(
              icon: Icons.business_center_outlined,
              label: "Business",
              isActive: true,
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(height: 8),
            _DrawerItem(
              icon: Icons.palette_outlined,
              label: "Culture",
              isActive: true,
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(height: 8),
            _DrawerItem(
              icon: Icons.bookmark_outline_rounded,
              label: "Saved Stories",
              isActive: true,
              onTap: () => Navigator.pop(context),
            ),
            const Spacer(),

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

class _userSection extends StatelessWidget {
  const _userSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: AppColors.primary,
            child: Icon(
              Icons.person_rounded,
              size: 32,
              color: AppColors.onPrimary,
            ),
          ),

          const SizedBox(height: 12),
          Text('Abdos', style: AppTypography.titleLg),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary,
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
    super.key,
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
      leading: Icon(icon, color: color),
      title: Text(label, style: AppTypography.titleMd.copyWith(color: color)),
      tileColor: isActive
          ? AppColors.primary.withOpacity(0.1)
          : Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onTap: onTap,
    );
  }
}

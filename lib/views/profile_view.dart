// import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ffi';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/providers/auth_provider.dart';
import 'package:news_app/theme/app_colors.dart';
import 'package:news_app/theme/typography.dart';
// import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [const _UserHeader(), const _GoPremiumCard()],
      ),
    );
  }
}

class _UserHeader extends StatelessWidget {
  const _UserHeader();

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().curentUser;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),

          Stack(
            children: [
              _Avatar(photoUrl: user?.photoURL),
              Positioned(bottom: 0, right: 0, child: _editAvatarButton()),
            ],
          ),

          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(99),
            ),
            child: Text(
              'JOURNAALIST MEMBER',
              style: AppTypography.caption.copyWith(
                color: AppColors.onPrimary,
                letterSpacing: 0.08,
              ),
            ),
          ),
          SizedBox(height: 12),
          Text(
            user?.displayName ?? 'Chronicler Member',
            style: AppTypography.displayMd,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            'Chroincling the intersection of global economics and cultural shifts.',
            style: AppTypography.body.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _statItem(value: '142', label: 'Saved Story'),
              _statDivider(),
              _statItem(value: '12', label: 'Followed Series'),
              _statDivider(),
              _statItem(
                value: _formatJoinDate(user?.metadata.creationTime),
                label: "Joined",
              ),
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  String _formatJoinDate(DateTime? date) {
    if (date == null) return '-';
    final months = [
      'Jan',
      'Fab',
      'Mar',
      'Apr',
      'May',
      'Juj',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.year}';
  }
}

class _statItem extends StatelessWidget {
  const _statItem({required this.value, required this.label});
  final String value;
  final String label;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Text(value, style: AppTypography.titleLg),
        const SizedBox(height: 2),
        Text(label, style: AppTypography.caption, textAlign: TextAlign.center),
      ],
    );
  }
}

class _statDivider extends StatelessWidget {
  const _statDivider();
  // const _statDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      color: AppColors.surfaceContainerHigh,
    );
  }
}

class _GoPremiumCard extends StatelessWidget {
  const _GoPremiumCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.all(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              // spacing: ,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.onPrimary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.star_rounded,
                    color: AppColors.onPrimary,
                    size: 20,
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  'Go Premium',
                  style: AppTypography.titleLg.copyWith(
                    color: AppColors.onPrimary,
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            const SizedBox(height: 4),

            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.onPrimary,
                side: const BorderSide(color: AppColors.onPrimary, width: 1.5),
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 10,
                ),
              ),
              child: Text('UPGRADE NOW', style: AppTypography.buttonLabel),
            ),
          ],
        ),
      ),
    );
  }
}

class _editAvatarButton extends StatelessWidget {
  const _editAvatarButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
          border: Border.all(
            color: Theme.of(context).colorScheme.surface,
            width: 2,
          ),
        ),
        child: Icon(
          Icons.camera_alt_rounded,
          size: 14,
          color: AppColors.onPrimary,
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({this.photoUrl});
  final String? photoUrl;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 70,
      backgroundColor: AppColors.primary,
      backgroundImage: photoUrl != null ? NetworkImage(photoUrl!) : null,
      child: photoUrl == null
          ? Icon(
              Icons.person_rounded,
              size: 100,
              color: AppColors.onSurfaceVariant,
            )
          : null,
    );
  }
}

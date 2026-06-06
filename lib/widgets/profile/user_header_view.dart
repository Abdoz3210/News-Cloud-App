import 'package:flutter/material.dart';
import 'package:news_app/core/providers/auth_provider.dart';
import 'package:news_app/theme/app_colors.dart';
import 'package:news_app/theme/typography.dart';
import 'package:news_app/widgets/profile/avatar.dart';
import 'package:news_app/widgets/profile/stat_item.dart';
import 'package:provider/provider.dart';
class UserHeader extends StatelessWidget {
  const UserHeader({super.key});

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
              Avatar(),
              Positioned(bottom: 0, right: 0, child: EditAvatarButton()),
            ],
          ),

          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              // color: AppColors.primary,
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
              StatItem(value: '142', label: 'Saved Story'),
              StatDivider(),
              StatItem(value: '12', label: 'Followed Series'),
              StatDivider(),
              StatItem(
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

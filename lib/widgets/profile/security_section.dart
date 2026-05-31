import 'package:flutter/material.dart';
import 'package:news_app/theme/app_colors.dart';
import 'package:news_app/widgets/profile/change_password_sheet.dart';
import 'package:news_app/widgets/profile/section_card.dart';
import 'package:news_app/widgets/profile/setting_section.dart';



class SecuritySection extends StatefulWidget {
  const SecuritySection({super.key});

  @override
  State<SecuritySection> createState() => SecuritySectionState();
}

class SecuritySectionState extends State<SecuritySection> {
  bool _twoFactorEnabled = false;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Security',
      icon: Icons.shield_outlined,
      children: [
        SettingRow(
          label: 'Change Password',
          trailling: const Icon(
            Icons.chevron_right_rounded,
            color: AppColors.onSurfaceVariant,
          ),
          onTap: () => _showChangePasswordSheet(context),
        ),

        const SettingsDivider(),
        SettingRow(
          label: 'Two-Factor Auth',
          trailling: Switch(
            value: _twoFactorEnabled,
            onChanged: (value) {
              setState(() {
                _twoFactorEnabled = value;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Two-Factor auth coming soon!")),
              );
            },
          ),
          onTap: null,
        ),
      ],
    );
  }
}

void _showChangePasswordSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => const ChangePasswordSheet(),
  );
}

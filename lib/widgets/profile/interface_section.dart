import 'package:flutter/material.dart';
import 'package:news_app/core/providers/theme_providers.dart';
import 'package:news_app/theme/app_colors.dart';
import 'package:news_app/theme/typography.dart';
import 'package:news_app/widgets/profile/section_card.dart';
import 'package:news_app/widgets/profile/setting_section.dart';
import 'package:provider/provider.dart';

class InterfaceSection extends StatefulWidget {
  const InterfaceSection({super.key});

  @override
  State<InterfaceSection> createState() => _InterfaceSectionState();
}

class _InterfaceSectionState extends State<InterfaceSection> {
  String _selectedLanguage = 'English (UK)';

  final List<String> _languages = [
    'English (UK)',
    'English (US)',
    'Arabic',
    'French',
    'Spanish',
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return SectionCard(
      title: 'Interface',
      icon: Icons.language_rounded,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'DISPLAY LANGUAGE',
              style: AppTypography.categoryTag.copyWith(
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _selectedLanguage,
              decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(
                  context,
                ).colorScheme.surfaceContainerHighest,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              items: _languages.map((lang) {
                return DropdownMenuItem(
                  value: lang,
                  child: Text(lang, style: AppTypography.body),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedLanguage = value);
                }
              },
            ),
          ],
        ),

        const SizedBox(height: 16),
        const SettingsDivider(),
        const SizedBox(height: 16),

        SettingRow(
          label: 'Dark Mode',
          trailling: Switch(
            value: themeProvider.isDark,
            onChanged: (value) => themeProvider.toggleTheme(value),
          ),
          onTap: null,
        ),
      ],
    );
  }
}

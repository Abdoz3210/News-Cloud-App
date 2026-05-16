import 'package:flutter/material.dart';
import 'package:news_app/widgets/components/app_button.dart';
import 'package:news_app/widgets/components/app_chip.dart';
import 'package:news_app/widgets/components/app_input.dart';
import 'package:news_app/widgets/components/app_card.dart';
import 'package:news_app/theme/typography.dart';
import 'package:news_app/theme/app_colors.dart';

class DesignTestViews extends StatefulWidget {
  const DesignTestViews({super.key});

  @override
  State<DesignTestViews> createState() => _DesignTestViewsState();
}

class _DesignTestViewsState extends State<DesignTestViews> {
  bool _chipActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Design System Test')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("typography", style: AppTypography.categoryTag),
            const SizedBox(height: 12),
            Text('Display Large', style: AppTypography.displayLg),
            Text('Headline', style: AppTypography.headline),
            Text('Body text example', style: AppTypography.body),
            Text('Caption text', style: AppTypography.caption),
            const SizedBox(height: 32),
            // buttons
            Text('BUTTONS', style: AppTypography.categoryTag),
            const SizedBox(height: 12),
            AppButton(label: 'Sign In', onPressed: () {}, isLoading: false),
            const SizedBox(height: 12),
            AppButtonSecondary(label: 'Secondary', onPressed: () {}),
            const SizedBox(height: 12),
            AppButtonTertiary(label: 'Tertiary', onPressed: () {}),
            const SizedBox(height: 32),
            // ── Chip ─────────────────────────────────────────
            Text('CHIP', style: AppTypography.categoryTag),
            const SizedBox(height: 12),
            AppChip(
              label: 'Top Stories',
              isActive: _chipActive,
              onTap: () => setState(() => _chipActive = !_chipActive),
            ),
            const SizedBox(height: 32),
            // ── Input ─────────────────────────────────────────
            Text('INPUT', style: AppTypography.categoryTag),
            const SizedBox(height: 12),
            AppInput(label: 'Subscriber Email', hint: 'name@chronicler.com'),
            const SizedBox(height: 32),
            // ── Card ──────────────────────────────────────────
            Text('CARD', style: AppTypography.categoryTag),
            const SizedBox(height: 12),
            AppCard(
              child: Text(
                'This is a card component',
                style: AppTypography.body.copyWith(color: AppColors.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

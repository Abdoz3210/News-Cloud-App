import 'package:flutter/material.dart';
import 'package:news_app/theme/typography.dart';






class SettingRow extends StatelessWidget {
  const SettingRow({
    super.key,
    required this.label,
    required this.trailling,
    required this.onTap,
  });
  final String label;
  final Widget trailling;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTypography.titleMd),
            trailling,
          ],
        ),
      ),
    );
  }
}

class SettingsDivider extends StatelessWidget {
  const SettingsDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5,
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
    );
  }
}

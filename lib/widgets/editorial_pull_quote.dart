import 'package:flutter/material.dart';
import 'package:news_app/theme/app_colors.dart';
import 'package:news_app/theme/typography.dart';

class EditorialPullQuote extends StatelessWidget {
  const EditorialPullQuote({
    super.key,
    this.quote =
        '"In the digital age,the role of a chronicler is not '
        'just to report the facts, but to preserve the nuance of '
        'our shared human experience."',
    this.attribution = '— Elena Thorne, Editor-in-Chief',
  });
  final String quote;
  final String attribution;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '\u201c',
            style: TextStyle(
              fontFamily: 'Newsreader',
              fontSize: 60,
              height: 0.8,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 5),
          Text(quote, style: AppTypography.pullQuote),
          const SizedBox(height: 16),
          Text(
            attribution.toUpperCase(),
            style: AppTypography.caption.copyWith(
              color: AppColors.onSurfaceVariant,
              letterSpacing: 0.08,
            ),
          ),
        ],
      ),
    );
  }
}

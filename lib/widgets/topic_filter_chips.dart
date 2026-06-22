import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/constants/news_categories.dart';
import 'package:news_app/theme/app_colors.dart';
import 'package:news_app/theme/typography.dart';

class TopicFilterChips extends StatelessWidget {
  const TopicFilterChips({
    required this.selectedCategory,
    required this.onCategoryChanged,
  });
  final String selectedCategory;
  final ValueChanged<String> onCategoryChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        itemCount: NewsCategories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = NewsCategories[index];
          final isActive = category.apiValue == selectedCategory;

          return _FilterChip(
            label: category.label,
            isActive: isActive,
            ontap: () => onCategoryChanged(category.apiValue),
          );
        },
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isActive,
    required this.ontap,
  });
  final String label;
  final bool isActive;
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: AnimatedContainer(
        width: 150,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primary
              : Theme.of(context).colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(99),
        ),
        child: Center(
          child: Text(
            label.toUpperCase(),
            style: AppTypography.categoryTag.copyWith(
              color: isActive
                  ? AppColors.onPrimary
                  : AppColors.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}

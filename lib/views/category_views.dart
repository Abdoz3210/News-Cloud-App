import 'package:flutter/material.dart';
import 'package:news_app/theme/app_colors.dart';
import 'package:news_app/theme/typography.dart';
import 'package:news_app/widgets/news_list_builder.dart';

class CategoryViews extends StatelessWidget {
  const CategoryViews({super.key, required this.category});
  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(category, style: AppTypography.headline),
      ),
      body: CustomScrollView(
        slivers: [NewsListBuilder(caregory: category.toLowerCase())],
      ),
    );
  }
}

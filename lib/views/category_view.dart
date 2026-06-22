import 'package:flutter/material.dart';
import 'package:news_app/widgets/amber_category_header.dart';
import 'package:news_app/widgets/news_list_builder.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key, required this.category, required this.label});
  final String category;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AmberCategoryHeader(title: label),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [NewsListBuilder(caregory: category)],
      ),
    );
  }
}

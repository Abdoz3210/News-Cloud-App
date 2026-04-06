import 'package:flutter/material.dart';
import 'package:news_app/widgets/news_list_builder.dart';

class CategoryViews extends StatelessWidget {
  const CategoryViews({super.key, required this.category});
  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(category, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: CustomScrollView(
        slivers: [NewsListBuilder(caregory: category.toLowerCase())],
      ),
    );
  }
}

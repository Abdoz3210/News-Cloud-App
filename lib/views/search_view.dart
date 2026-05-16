import 'package:flutter/material.dart';
import 'package:news_app/theme/typography.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Search - comming Soon', style: AppTypography.headline),
    );
  }
}

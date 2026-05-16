import 'package:flutter/material.dart';
import 'package:news_app/theme/typography.dart';

class SavedView extends StatelessWidget {
  const SavedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Saved - comming Soon', style: AppTypography.headline),
    );
  }
}

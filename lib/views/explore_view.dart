import 'package:flutter/material.dart';
import 'package:news_app/theme/typography.dart';


class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: Text('Explore - comming Soon', style: AppTypography.headline,),
    );
  }
}
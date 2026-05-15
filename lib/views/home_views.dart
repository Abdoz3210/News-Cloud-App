import 'package:flutter/material.dart';
import 'package:news_app/theme/app_colors.dart';
import 'package:news_app/theme/typography.dart';
import 'package:news_app/widgets/categorylist.dart';
// import 'package:news_app/widgets/newscard.dart';
import 'package:news_app/widgets/news_list_builder.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // final double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: AppColors.surface,
        centerTitle: true,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: 'News', style: AppTypography.headline),
                TextSpan(text: "Cloud", style: AppTypography.headlineColor),
              ],
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        // mainAxisSize: MainAxisSize.min,
        slivers: [
          SliverToBoxAdapter(child: CategoryList()),
          NewsListBuilder(caregory: 'general'),
          // NewsCard(),
        ],
      ),
    );
  }
}

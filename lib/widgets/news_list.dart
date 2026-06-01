import 'package:flutter/material.dart';
import 'package:news_app/Models/articales_model.dart';
import 'package:news_app/widgets/hero_article_card.dart';
import 'package:news_app/widgets/newscard.dart';

class NewsList extends StatelessWidget {
  const NewsList({required this.articals, super.key});
  final List<ArticalModel> articals;
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(childCount: articals.length, (
        context,
        index,
      ) {
        // return NewsCard(artical: articals[index])
        return HeroArticleCard(artical: articals[index], onTap: () {});
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:news_app/widgets/newscard.dart';

class NewsList extends StatelessWidget {
  const NewsList({super.key});

  @override
  Widget build(BuildContext context) {
    // final double height = MediaQuery.sizeOf(context).height;
    // final double width = MediaQuery.sizeOf(context).width;
    return SliverList(
      delegate: SliverChildBuilderDelegate(childCount: 5, (context, index) {
        return const NewsCard();
      }),
    );
  }
}

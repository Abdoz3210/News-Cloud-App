import 'package:flutter/material.dart';
import 'package:news_app/widgets/categorylist.dart';
import 'package:news_app/widgets/news_list_builder.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // final double height = MediaQuery.sizeOf(context).height;
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      // mainAxisSize: MainAxisSize.min,
      slivers: [
        // SliverToBoxAdapter(
        //   child: AppTopBar(
        //     title: 'News Cloud',
        //     leading: Icon(Icons.menu_rounded),
        //     actions: [
        //       IconButton(
        //         onPressed: () {},
        //         icon: Icon(Icons.person_outline_rounded),
        //       ),
        //     ],
        //   ),
        // ),
        SliverToBoxAdapter(child: CategoryList()),
        NewsListBuilder(caregory: 'general'),
        // NewsCard(),
      ],
    );
  }
}

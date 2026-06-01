import 'package:flutter/material.dart';
import 'package:news_app/widgets/news_list_builder.dart';
import 'package:news_app/widgets/topic_filter_chips.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String _selectedCategory = 'general';

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
        SliverToBoxAdapter(
          child: TopicFilterChips(
            selectedCategory: _selectedCategory,
            onCategoryChanged: (category) =>
                setState(() => _selectedCategory = category),
          ),
        ),
        NewsListBuilder(caregory: _selectedCategory),
        // NewsCard(),
      ],
    );
  }
}

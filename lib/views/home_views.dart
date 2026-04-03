import 'package:flutter/material.dart';
import 'package:news_app/Models/models.dart';
import 'package:news_app/widgets/categorylist.dart';
// import 'package:news_app/widgets/newscard.dart';
import 'package:news_app/widgets/news_list_builder.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  final ImageInfoModel imageInfo = const ImageInfoModel(
    image: 'assets/business.png',
    title: 'Business',
  );

  @override
  Widget build(BuildContext context) {
    // final double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,

        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RichText(
            text: TextSpan(
              text: 'News',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: "Cloud",
                  style: TextStyle(color: Colors.amber),
                ),
              ],
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        // mainAxisSize: MainAxisSize.min,
        slivers: [
          SliverToBoxAdapter(child: CategoryList()),
          NewsListBuilder(),
          // NewsCard(),
        ],
      ),
    );
  }
}

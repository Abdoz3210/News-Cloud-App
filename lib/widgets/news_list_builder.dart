import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Models/articales_model.dart';
import 'package:news_app/services/getnews.dart';
import 'package:news_app/theme/typography.dart';
import 'package:news_app/widgets/news_list.dart';

class NewsListBuilder extends StatefulWidget {
  const NewsListBuilder({super.key, required this.caregory});
  final String caregory;

  @override
  State<NewsListBuilder> createState() => _NewsListState();
}

class _NewsListState extends State<NewsListBuilder> {
  var future;
  @override
  void initState() {
    // getGeneralNews();
    future = NewsServce(Dio()).getGeneral(category: widget.caregory);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final double height = MediaQuery.sizeOf(context).height;
    // final double width = MediaQuery.sizeOf(context).width;
    return FutureBuilder<List<ArticalModel>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return NewsList(articals: snapshot.data ?? []);
        } else if (snapshot.hasError) {
          return SliverToBoxAdapter(
            child: Text(
              "There are an Error, Try again later ",
              style: AppTypography.body,
            ),
          );
        } else {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(150.0),
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }
      },
    );
  }
}
// isLoading == true
    //     ? SliverToBoxAdapter(
    //         child: Padding(
    //           padding: EdgeInsets.symmetric(vertical: height / 3),
    //           child: Center(child: CircularProgressIndicator()),
    //         ),
    //       )
    // : SliverList(
    //     delegate: SliverChildBuilderDelegate(childCount: articals.length, (
    //       context,
    //       index,
    //     ) {
    //       return NewsCard(artical: articals[index]);
    //     }),
    //       );
import 'package:flutter/material.dart';
// import 'package:news_app/Models/models.dart';
import 'dart:math' as math;

import 'package:news_app/Models/articales_model.dart';

Color randomMaterialColor() {
  final randomIndex = math.Random().nextInt(Colors.primaries.length);
  return Colors.primaries[randomIndex];
}

class NewsCard extends StatelessWidget {
  const NewsCard({super.key, required this.artical});

  final ArticalModel artical;
  // final NewsInfoModel newsInfo;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final double height = MediaQuery.sizeOf(context).height;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width,
            height: height * 0.25,

            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),

                image: artical.image == null
                    ? null
                    : DecorationImage(
                        image: NetworkImage(artical.image!),
                        fit: BoxFit.fill,
                      ),
                color: artical.image != null ? null : randomMaterialColor(),
              ),
              child: artical.image != null ? null : Icon(Icons.api),
            ),
          ),
          Text(
            artical.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            artical.descriptation ?? " ",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,

            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}

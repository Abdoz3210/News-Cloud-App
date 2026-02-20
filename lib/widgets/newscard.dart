import 'package:flutter/material.dart';
// import 'package:news_app/Models/models.dart';
import 'dart:math' as math;

Color randomMaterialColor() {
  final randomIndex = math.Random().nextInt(Colors.primaries.length);
  return Colors.primaries[randomIndex];
}

class NewsCard extends StatelessWidget {
  const NewsCard({super.key});
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
                color: randomMaterialColor(),
              ),
              child: Icon(Icons.api),
            ),
          ),
          Text(
            "tital tital tital tital tital tital ",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            "News News News News News News News News News News News News News News News News News News News News News News News News ",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,

            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}

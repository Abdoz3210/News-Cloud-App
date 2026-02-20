import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:news_app/Models/models.dart';

class HeroCategoryCard extends StatelessWidget {
  const HeroCategoryCard({super.key, required this.imageInfo});
  final ImageInfoModel imageInfo;
  // Accessing the screen size and orientation

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.sizeOf(context).height;
    return Container(
      margin: EdgeInsets.only(left: 20),
      // padding: EdgeInsets.symmetric(horizontal: 10),
      // color: Colors.amber,
      height: height,
      width: width * 0.5,
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(imageInfo.image),
          fit: BoxFit.fill,
        ),
      ),
      child: Center(
        child: Text(
          imageInfo.title,
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

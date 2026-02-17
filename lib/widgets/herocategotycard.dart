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

    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        ClipRect(
          child: OverflowBox(
            minWidth: width * 7 / 8,
            maxWidth: width * 7 / 8,
            child: Image(image: AssetImage(imageInfo.image), fit: BoxFit.cover),
          ),
        ),

        OverflowBox(
          minWidth: width * 7 / 8,
          maxWidth: width * 7 / 8,
          child: Center(
            child: Text(
              imageInfo.title,
              overflow: TextOverflow.clip,
              softWrap: true,
              style: TextStyle(
                fontSize: 30,
                color: Colors.grey,
                fontWeight: FontWeight.w900,
                letterSpacing: 5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

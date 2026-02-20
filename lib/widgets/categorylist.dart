// import 'dart:async';
// import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:flutter/material.dart';
import 'package:news_app/Models/models.dart';
import 'package:news_app/widgets/herocategotycard.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final List<ImageInfoModel> imageinfo = const [
    ImageInfoModel(image: "assets/business.png", title: "Business"),
    ImageInfoModel(image: "assets/entertaiment.png", title: "Entertaiment"),
    ImageInfoModel(image: "assets/general.png", title: "General"),
    ImageInfoModel(image: "assets/health.png", title: "Healthy"),
    ImageInfoModel(image: "assets/science.png", title: "Science"),
    ImageInfoModel(image: "assets/sports.png", title: "Sports"),
    ImageInfoModel(image: "assets/technology.png", title: "Technology"),
  ];

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;
    return SizedBox(
      width: width,
      height: height * 0.15,
      child: ListView (
        scrollDirection: Axis.horizontal,
        children: imageinfo.map((e) {
          return HeroCategoryCard(imageInfo: e);
        }).toList(),
      ),
    );
  }
}

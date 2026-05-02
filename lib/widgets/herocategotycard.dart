import 'package:flutter/material.dart';
import 'package:news_app/Models/category_models.dart';
import 'package:news_app/theme/app_colors.dart';
import 'package:news_app/theme/typography.dart';
import 'package:news_app/views/category_views.dart';

class HeroCategoryCard extends StatelessWidget {
  const HeroCategoryCard({super.key, required this.categoryModel});
  final CategoryModel categoryModel;
  // Accessing the screen size and orientation

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.sizeOf(context).height;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryViews(category: categoryModel.title),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(left: 20),
        // padding: EdgeInsets.symmetric(horizontal: 10),
        // color: Colors.amber,
        height: height,
        width: width * 0.5,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage(categoryModel.image),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Text(categoryModel.title, style: AppTypography.buttonLabel),
        ),
      ),
    );
  }
}

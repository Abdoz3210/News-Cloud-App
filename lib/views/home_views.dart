import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:news_app/Models/models.dart';
import 'package:news_app/widgets/herocategotycard.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  final ImageInfoModel imageInfo = const ImageInfoModel(
    image: 'assets/business.png',
    title: 'Business',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
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
        centerTitle: true,
      ),
      body: HeroCategoryCard(imageInfo: imageInfo,),
    );
  }
}

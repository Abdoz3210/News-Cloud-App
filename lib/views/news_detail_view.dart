import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:news_app/Models/articales_model.dart';
import 'package:news_app/core/services/getnews.dart';
import 'package:news_app/theme/app_colors.dart';
import 'package:news_app/theme/typography.dart';

class NewsDetailView extends StatefulWidget {
  const NewsDetailView({super.key, required this.articale});

  final ArticalModel articale;

  @override
  State<NewsDetailView> createState() => _NewsDetailViewState();
}

class _NewsDetailViewState extends State<NewsDetailView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

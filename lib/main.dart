import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/views/home_views.dart';
import 'package:news_app/services/getnews.dart';

final dio =Dio();
void main() {
  runApp(const NewsApp());
  NewsServce(dio).getGeneral();
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}

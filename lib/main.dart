import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/views/home_views.dart';
import 'theme/app_theme.dart';

final dio = Dio();
void main() {
  runApp(const NewsApp());
  // NewsServce(dio).getGeneral();
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const HomeView(),
    );
  }
}

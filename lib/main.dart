import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/providers/theme_providers.dart';
import 'package:news_app/views/design_test_views.dart';
import 'package:news_app/views/home_views.dart';
import 'package:news_app/views/main_view.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';

final dio = Dio();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProviders()..loadTheme(),
      child: const NewsApp(),
    ),
  );
  // NewsServce(dio).getGeneral();
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      // home: const DesignTestViews(),
      home: const MainView(),
    );
  }
}

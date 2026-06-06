import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/providers/auth_gate.dart';
import 'package:news_app/core/providers/auth_provider.dart';
import 'package:news_app/core/providers/theme_providers.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:news_app/firebase_options.dart';

final dio = Dio();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // FlutterNativeSplash.preserve(widgetsBinding: WidgetsBinding.instance);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()..loadTheme()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const NewsApp(),
    ),
  );
  // NewsServce(dio).getGeneral();
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeProvider.themeMode,
      // home: const DesignTestViews(),
      home: const AuthGate(),
    );
  }
}

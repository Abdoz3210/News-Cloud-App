import 'package:flutter/material.dart';
import 'package:news_app/views/home_views.dart';
import 'package:news_app/views/explore_view.dart';
import 'package:news_app/views/search_view.dart';
import 'package:news_app/views/saved_view.dart';
import 'package:news_app/views/profile_view.dart';
import 'package:news_app/widgets/components/app_bottom_nav.dart';
import 'package:news_app/widgets/components/app_drawer.dart';
import 'package:news_app/widgets/components/app_top_bar.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _screens = const [
    ProfileView(),
    HomeView(),
    ExploreView(),
    SearchView(),
    SavedView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      appBar: AppTopBar(
        title: 'The Chronicler',
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.person_outline_rounded),
          ),
        ],
      ),
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}

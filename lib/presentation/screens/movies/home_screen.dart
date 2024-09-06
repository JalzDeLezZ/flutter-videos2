// ignore_for_file: prefer_const_literals_to_create_immutables, avoid_print
import 'package:cinema_movie_new/presentation/providers/theme_provider.dart';
import 'package:cinema_movie_new/presentation/views/views.dart';
import 'package:cinema_movie_new/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  static const name = 'home-screen';
  final int pageIndex;

  HomeScreen({super.key, required this.pageIndex});

  final viewRoutes = [const HomeView(), const FavoritesView()];

  @override
  Widget build(BuildContext context, ref) {
    final isDarkMode = ref.watch(themeNotifierProvider).isDarkmode;

    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: viewRoutes,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
        onPressed: () => {
          ref.read(themeNotifierProvider.notifier).toggleTheme(),
        },
        tooltip: 'Dark Mode',
        child: Icon(
            isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavigation(currentIndex: pageIndex),
    );
  }
}

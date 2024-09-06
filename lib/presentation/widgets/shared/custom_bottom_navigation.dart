import 'package:cinema_movie_new/presentation/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends ConsumerWidget {
  const CustomBottomNavigation({super.key, required this.currentIndex});

  final int currentIndex;
  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home/0');
        break;
      case 1:
        context.go('/home/1');
        break;
      default:
        context.go('/home/0');
    }
  }

  @override
  Widget build(BuildContext context, ref) {
    final isDarkMode = ref.watch(themeNotifierProvider).isDarkmode;
    final colors = Theme.of(context).colorScheme;
    final decoration = BoxDecoration(
      color: Colors.transparent,
      // borderRadius: const BorderRadius.only(
      //   topLeft: Radius.circular(30),
      //   topRight: Radius.circular(30),
      // ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: colors.primary,
          blurRadius: 10,
          // offset: const Offset(0, 10),
        ),
      ],
    );
    return Container(
      decoration: decoration,
      // child: ClipRRect(
      //   borderRadius: const BorderRadius.only(
      //       topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      child: BottomNavigationBar(
        // type: BottomNavigationBarType.shifting,
        // showSelectedLabels: false,
        // showUnselectedLabels: false,
        elevation: 0,
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        selectedItemColor: colors.primary,
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        onTap: (value) => onItemTapped(context, value),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Inicio'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline), label: 'Favoritos'),
        ],
      ),
      // ),
    );
  }
}

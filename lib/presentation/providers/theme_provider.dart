import 'package:cinema_movie_new/config/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeNotifierProvider =
    StateNotifierProvider<Controller, AppTheme>((ref) => Controller());

class Controller extends StateNotifier<AppTheme> {
  Controller() : super(AppTheme());

  void toggleTheme() {
    state = state.copyWith(isDarkmode: !state.isDarkmode);
  }
}

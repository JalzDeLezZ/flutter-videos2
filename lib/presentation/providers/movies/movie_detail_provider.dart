// ignore_for_file: avoid_print

import 'package:cinema_movie_new/domain/entities/movie.dart';
import 'package:cinema_movie_new/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Callback
typedef GetMovieCallback = Future<Movie> Function(String movieId);

//* Notifier
class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback getMovie;

  MovieMapNotifier({required this.getMovie}) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;

    final movie = await getMovie(movieId);

    state = {
      ...state,
      movieId: movie,
    };
  }
}

//* Provider Methods for Movies
final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final getMovie = ref.watch(movieRepositoryProvider);
  return MovieMapNotifier(getMovie: getMovie.getMovieById);
});

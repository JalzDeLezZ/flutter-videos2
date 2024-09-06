import 'package:cinema_movie_new/presentation/providers/movies/initial_loading_provider.dart';
import 'package:cinema_movie_new/presentation/providers/movies/movies_providers.dart';
import 'package:cinema_movie_new/presentation/providers/movies/movies_slideshow_provider.dart';
import 'package:cinema_movie_new/presentation/screens/movies/movie_horizontal_listview.dart';
import 'package:cinema_movie_new/presentation/widgets/movies/movies_slideshow.dart';
import 'package:cinema_movie_new/presentation/widgets/shared/custom_appbar.dart';
import 'package:cinema_movie_new/presentation/widgets/shared/full_screen_loader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullScreenLoader();

    final newPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          title: CustomAppbar(),
          titlePadding: EdgeInsets.zero,
          centerTitle: false,
        ),
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            MoviesSlideshow(movies: slideShowMovies),
            MovieHorizontalListview(
                movies: newPlayingMovies,
                title: 'En Cines',
                subtitle: 'Lunes 20',
                onNextPage: () =>
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage()),
            MovieHorizontalListview(
                movies: upcomingMovies,
                title: 'Próximamente',
                subtitle: 'Este mes',
                onNextPage: () =>
                    ref.read(upcomingMoviesProvider.notifier).loadNextPage()),
            MovieHorizontalListview(
                movies: popularMovies,
                title: 'Populares',
                onNextPage: () =>
                    ref.read(popularMoviesProvider.notifier).loadNextPage()),
            MovieHorizontalListview(
                movies: topRatedMovies,
                title: 'Mejor calificadas',
                subtitle: 'All time',
                onNextPage: () =>
                    ref.read(topRatedMoviesProvider.notifier).loadNextPage()),
            const SizedBox(height: 10)
          ],
        );
      }, childCount: 1))
    ]);
  }
}

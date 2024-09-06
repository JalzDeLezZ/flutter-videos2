import 'package:animate_do/animate_do.dart';
import 'package:cinema_movie_new/domain/entities/movie.dart';
import 'package:cinema_movie_new/presentation/providers/providers.dart';
import 'package:cinema_movie_new/presentation/widgets/movies/similar_movies.dart';
import 'package:cinema_movie_new/presentation/widgets/videos/videos_from_movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen';
  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    return Scaffold(
        body: CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        _CustomSliverAppBar(movie: movie),
        SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => _MovieDetails(movie: movie),
                childCount: 1))
      ],
    ));
  }
}

final isFavoriteProvider =
    FutureProvider.family.autoDispose((ref, int movieId) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return localStorageRepository.isMovieFavorite(movieId);
});

class _CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;
  const _CustomSliverAppBar({
    required this.movie,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));

    return SliverAppBar(
        backgroundColor: Colors.black,
        expandedHeight: size.height * 0.7,
        foregroundColor: Colors.white,
        titleSpacing: 0,
        actions: [
          IconButton(
            onPressed: () async {
              // OLD: await ref.read(localStorageRepositoryProvider).toggleFavorite(movie);
              await ref
                  .read(favoriteMoviesProvider.notifier)
                  .toggleFavorite(movie);
              ref.invalidate(isFavoriteProvider(movie.id));
            },
            icon: isFavoriteFuture.when(
              data: (res) => res
                  ? const Icon(Icons.favorite_rounded, color: Colors.red)
                  : const Icon(Icons.favorite_border),
              error: (_, __) => throw UnimplementedError(),
              loading: () => const CircularProgressIndicator(strokeWidth: 2),
            ),
          )
        ],
        flexibleSpace: FlexibleSpaceBar(
          titlePadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          centerTitle: false,
          background: Stack(children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();
                  return FadeIn(child: child);
                },
              ),
            ),
            const _CustomGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.6, 1],
                colors: [Colors.transparent, Color(0xBB000000)]),
            const _CustomGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0, 0.2],
                colors: [Color(0x60000000), Colors.transparent]),
            const _CustomGradient(
                begin: Alignment.topLeft,
                stops: [0, 0.3],
                colors: [Color(0x8D000000), Colors.transparent]),
          ]),
        ));
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.all(8),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //! Poster
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: Image.network(movie.posterPath,
                    width: size.width * 0.3, fit: BoxFit.cover),
              ),
              const SizedBox(width: 10),

              //! Description
              SizedBox(
                  width: (size.width - 40) * 0.7,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(movie.title, style: textStyle.titleLarge),
                        Text(movie.overview, style: textStyle.bodySmall),
                      ]))
            ])),

        //! Genres
        Padding(
            padding: const EdgeInsets.all(8),
            child: Wrap(
              spacing: 10, // spacing horizontally between chips
              runSpacing: 10, // spacing vertically between chips
              children: movie.genreIds
                  .map((e) => Chip(
                      label: Text(e),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))))
                  .toList(),
            )),

        //! Actors
        _ActorsByMovie(movieId: movie.id.toString()),

        //* Videos de la película (si tiene)
        VideosFromMovie(movieId: movie.id),

        //* Películas similares
        SimilarMovies(movieId: movie.id),

        const SizedBox(height: 40),
      ],
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final String movieId;

  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, ref) {
    //? Get Actors by Movie
    final actorsByMovie = ref.watch(actorsByMovieProvider);

    if (actorsByMovie[movieId] == null) {
      return const Center(child: CircularProgressIndicator());
    }
    final actors = actorsByMovie[movieId]!;

    return SizedBox(
      height: 300,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: actors.length,
          itemBuilder: (context, index) {
            final actor = actors[index];
            return Container(
              padding: const EdgeInsets.all(8),
              width: 135,
              child: Column(children: [
                //? Actor Photo
                FadeInRight(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(actor.profilePath,
                        width: 135, height: 180, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 10),
                //? Actor Name
                Text(actor.name,
                    maxLines: 2, style: Theme.of(context).textTheme.bodySmall),
                //? Actor Character
                Text(actor.character ?? '',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis)),
              ]),
            );
          }),
    );
  }
}

class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;

  const _CustomGradient(
      {this.begin = Alignment.centerLeft,
      this.end = Alignment.centerRight,
      required this.stops,
      required this.colors});
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: DecoratedBox(
            decoration: BoxDecoration(
                gradient: LinearGradient(
      begin: begin,
      end: end,
      stops: stops,
      colors: colors,
    ))));
  }
}

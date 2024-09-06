// ignore_for_file: avoid_print

import 'package:cinema_movie_new/domain/entities/movie.dart';
import 'package:cinema_movie_new/presentation/delegates/search_movie_delegate.dart';
import 'package:cinema_movie_new/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Icon(Icons.movie_outlined, color: colors.primary, size: 30),
            const SizedBox(width: 10),
            Text('Cinema Movie', style: titleStyle),
            const Spacer(),
            IconButton(
              icon: Icon(Icons.search, color: colors.primary),
              onPressed: () {
                final searchedMovies = ref.read(searchedMoviesProvider);
                final searchQuery = ref.read(searchQueryProvider);

                showSearch<Movie?>(
                        query: searchQuery,
                        context: context,
                        delegate: SeearchMovieDelegate(
                            initialMovies: searchedMovies,
                            searchMovieCallback: ref
                                .read(searchedMoviesProvider.notifier)
                                .searchMoviesByQuery))
                    .then((value) {
                  if (value != null) context.push('/home/0/movie/${value.id}');
                });
              },
            ),
          ],
        ),
      ),
    ));
  }
}

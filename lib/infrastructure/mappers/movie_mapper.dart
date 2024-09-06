import 'package:cinema_movie_new/domain/entities/movie.dart';
import 'package:cinema_movie_new/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinema_movie_new/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  /* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% */

  static Movie movieDBtoEntity(OnlyMovieDB movie_) => Movie(
      adult: movie_.adult,
      backdropPath: (movie_.backdropPath != '')
          ? 'https://image.tmdb.org/t/p/w500${movie_.backdropPath}'
          : 'https://via.placeholder.com/500x300.png?text=No+image',
      genreIds: movie_.genreIds.map((e) => e.toString()).toList(),
      id: movie_.id,
      originalLanguage: movie_.originalLanguage,
      originalTitle: movie_.originalTitle,
      overview: movie_.overview,
      popularity: movie_.popularity,
      posterPath: (movie_.posterPath != '')
          ? 'https://image.tmdb.org/t/p/w500${movie_.posterPath}'
          : 'https://www.movienewsletters.net/photos/000000H1.jpg',
      releaseDate:
          (movie_.releaseDate != null) ? movie_.releaseDate : DateTime.now(),
      title: movie_.title,
      video: movie_.video,
      voteAverage: movie_.voteAverage,
      voteCount: movie_.voteCount);

  /* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% */

  static Movie movieDetailsToEntity(MovieDetail movie_) => Movie(
      adult: movie_.adult,
      backdropPath: (movie_.backdropPath != '')
          ? 'https://image.tmdb.org/t/p/w500${movie_.backdropPath}'
          : 'https://via.placeholder.com/500x300.png?text=No+image',
      genreIds: movie_.genres.map((e) => e.name).toList(),
      id: movie_.id,
      originalLanguage: movie_.originalLanguage,
      originalTitle: movie_.originalTitle,
      overview: movie_.overview,
      popularity: movie_.popularity,
      posterPath: (movie_.posterPath != '')
          ? 'https://image.tmdb.org/t/p/w500${movie_.posterPath}'
          : 'https://www.movienewsletters.net/photos/000000H1.jpg',
      releaseDate: movie_.releaseDate,
      title: movie_.title,
      video: movie_.video,
      voteAverage: movie_.voteAverage,
      voteCount: movie_.voteCount);
}

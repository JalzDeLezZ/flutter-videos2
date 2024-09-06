import 'package:cinema_movie_new/domain/datasources/movies_datasource.dart';
import 'package:cinema_movie_new/domain/entities/movie.dart';
import 'package:cinema_movie_new/domain/entities/video.dart';
import 'package:cinema_movie_new/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {
  final MoviesDataSource innDataSource;
  MovieRepositoryImpl(this.innDataSource); // Constructor injection

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return innDataSource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return innDataSource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return innDataSource.getTopRated(page: page);
  }

  @override
  Future<List<Movie>> getUpcomming({int page = 1}) {
    return innDataSource.getUpcomming(page: page);
  }

  @override
  Future<Movie> getMovieById(String id) {
    return innDataSource.getMovieById(id);
  }

  @override
  Future<List<Movie>> searchMovies(String query) {
    return innDataSource.searchMovies(query);
  }

  @override
  Future<List<Movie>> getSimilarMovies(int movieId) {
    return innDataSource.getSimilarMovies(movieId);
  }

  @override
  Future<List<Video>> getYoutubeVideosById(int movieId) {
    return innDataSource.getYoutubeVideosById(movieId);
  }
}

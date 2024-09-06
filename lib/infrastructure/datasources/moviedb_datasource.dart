// ignore_for_file: avoid_print

import 'package:cinema_movie_new/config/constants/environment.dart';
import 'package:cinema_movie_new/domain/entities/entities.dart';
import 'package:cinema_movie_new/infrastructure/mappers/movie_mapper.dart';
import 'package:cinema_movie_new/infrastructure/mappers/video_mapper.dart';
import 'package:cinema_movie_new/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinema_movie_new/infrastructure/models/moviedb/moviedb_res.dart';
import 'package:cinema_movie_new/infrastructure/models/moviedb/moviedb_videos.dart';
import 'package:dio/dio.dart';
import 'package:cinema_movie_new/domain/datasources/movies_datasource.dart';

class MoviedbDatasource extends MoviesDataSource {
  final dio = Dio(
      BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
    'api_key': Environment.theMovieDbKey,
    'language': 'es-MX',
  }));

  List<Movie> _jsonToMovie(Map<String, dynamic> json) {
    final moviesRes = MovieDbResponse.fromJson(json);
    final List<Movie> movies = moviesRes.results
        .where((e) => e.posterPath != 'no-poster')
        .map((e2) => MovieMapper.movieDBtoEntity(e2))
        .toList();
    return movies;
  }

  //* Methods
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final res = await dio.get('/movie/now_playing', queryParameters: {
      'page': page,
    });
    return _jsonToMovie(res.data);
  }

  @override
  Future<List<Movie>> getUpcomming({int page = 1}) async {
    final res = await dio.get('/movie/upcoming', queryParameters: {
      'page': page,
    });
    return _jsonToMovie(res.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final res = await dio.get('/movie/popular', queryParameters: {
      'page': page,
    });
    return _jsonToMovie(res.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final res = await dio.get('/movie/top_rated', queryParameters: {
      'page': page,
    });
    return _jsonToMovie(res.data);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final res = await dio.get('/movie/$id');

    if (res.statusCode != 200) throw Exception('Movie with id $id not found');

    final movieDetails = MovieDetail.fromJson(res.data);

    return MovieMapper.movieDetailsToEntity(movieDetails);
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    if (query.isEmpty) return [];

    final res = await dio.get('/search/movie', queryParameters: {
      'query': query,
    });
    return _jsonToMovie(res.data);
  }

  @override
  Future<List<Movie>> getSimilarMovies(int movieId) async {
    final response = await dio.get('/movie/$movieId/similar');
    return _jsonToMovie(response.data);
  }

  @override
  Future<List<Video>> getYoutubeVideosById(int movieId) async {
    final response = await dio.get('/movie/$movieId/videos');
    print(response.data.toString());
    final moviedbVideosReponse = MoviedbVideosResponse.fromJson(response.data);

    final List<Video> videos = List<Video>.from(moviedbVideosReponse.results
        .where((element) => element.site == 'YouTube')
        .take(1)
        .map((e) => VideoMapper.moviedbVideoToEntity(e))
        .toList());

    return videos;
  }
}

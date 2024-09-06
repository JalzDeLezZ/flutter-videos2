import 'package:cinema_movie_new/config/constants/environment.dart';
import 'package:cinema_movie_new/domain/datasources/actors_datasource.dart';
import 'package:cinema_movie_new/domain/entities/actor.dart';
import 'package:cinema_movie_new/infrastructure/mappers/actor_mapper.dart';
import 'package:cinema_movie_new/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

class ActorMovieDbDataSource extends ActorsDatasource {
  final dio = Dio(
      BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
    'api_key': Environment.theMovieDbKey,
    'language': 'es-MX',
  }));

  @override
  Future<List<Actor>> getActosByMovie(String movieId) async {
    final res = await dio.get('/movie/$movieId/credits');

    final castResp = CreditsResponse.fromJson(res.data);

    List<Actor> actors =
        castResp.cast.map((e) => ActorMapper.castToEntity(e)).toList();

    return actors;
  }
}

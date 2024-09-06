import 'package:cinema_movie_new/domain/entities/actor.dart';

abstract class ActorsDatasource {
  Future<List<Actor>> getActosByMovie(String movieId);
}

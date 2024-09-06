import 'package:cinema_movie_new/domain/datasources/actors_datasource.dart';
import 'package:cinema_movie_new/domain/entities/actor.dart';
import 'package:cinema_movie_new/domain/repositories/actors_repository.dart';

class ActorRepositoryImpl extends ActorsRepository {
  // Attributes
  final ActorsDatasource actorsDatasource;

  // Constructor
  ActorRepositoryImpl(this.actorsDatasource);

  // Methods
  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return actorsDatasource.getActosByMovie(movieId);
  }
}

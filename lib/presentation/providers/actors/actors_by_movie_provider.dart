import 'package:cinema_movie_new/domain/entities/actor.dart';
import 'package:cinema_movie_new/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Callback
typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

// Notifier
class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallback getActors;

  ActorsByMovieNotifier({required this.getActors}) : super({});

  // This method is called from the UI
  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;

    final List<Actor> actors = await getActors(movieId);

    state = {
      ...state,
      movieId: actors,
    };
  }
}

// Provider Methods for Actors
final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>(
        (ref) {
  final actorRepository_ = ref.watch(actorRepositoryProvider);
  return ActorsByMovieNotifier(getActors: actorRepository_.getActorsByMovie);
});

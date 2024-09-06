import 'package:cinema_movie_new/domain/entities/actor.dart';
import 'package:cinema_movie_new/infrastructure/models/moviedb/credits_response.dart';

class ActorMapper {
  static Actor castToEntity(Cast cast) => Actor(
        id: cast.id,
        name: cast.name,
        character: cast.character,
        profilePath: cast.profilePath != null
            ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
            : 'https://th.bing.com/th/id/OIP.GlOJ2dXK8Kpz13D-gKExlwAAAA?pid=ImgDet&rs=1',
      );
}

import 'package:cinema_movie_new/domain/entities/entities.dart';
import 'package:cinema_movie_new/infrastructure/models/moviedb/moviedb_videos.dart';

class VideoMapper {
  static moviedbVideoToEntity(Result moviedbVideo) {
    print('moviedbVideo: $moviedbVideo');
    return Video(
        id: moviedbVideo.id,
        name: moviedbVideo.name,
        youtubeKey: moviedbVideo.key,
        publishedAt: moviedbVideo.publishedAt);
  }
}

import 'package:cinema/domain/entities/actor.dart';
import 'package:cinema/infrastructure/models/moviedb/movie_actors.dart';

class ActorMaper {
  static Actor castToEntity(Cast cast) => Actor(
    id: cast.id, 
    name: cast.name, 
    profilePath: (cast.profilePath!= null)
          ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
          : 'https://media.istockphoto.com/id/517998264/vector/male-user-icon.jpg?s=612x612&w=0&k=20&c=4RMhqIXcJMcFkRJPq6K8h7ozuUoZhPwKniEke6KYa_k=',
    character: cast.character ?? ''
    );
}

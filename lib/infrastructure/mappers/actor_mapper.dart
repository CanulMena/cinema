import 'package:cinema/domain/entities/actor.dart';
import 'package:cinema/infrastructure/models/moviedb/movie_actors.dart';

class ActorMaper {
  static Actor castToEntity(Cast cast) => Actor(
    id: cast.id, 
    name: cast.name, 
    profilePath: (cast.profilePath!= null)
          ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
          : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTi7MdCF1KEsTUCfWsA_7Z2nsWaIo7CBlhOaw&usqp=CAU',
    character: cast.character ?? ''
    );
}

import 'package:cinema/domain/entities/actor.dart';
import 'package:cinema/infrastructure/datasource/actor_moviedb_datasource.dart';
import 'package:cinema/infrastructure/repositories/actors_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsMovieProvider = StateNotifierProvider<ActorsNotifier, Map<String, List<Actor>>>((ref){
  final fetchActors = ActorsRepositoryImpl(datasource: ActorMovieDbDatasource());
  return ActorsNotifier(
    fetchActors: fetchActors.getActorsByMoive
    );
});

  /*

    {
      '1234' : List<Actor>
    }

   */

typedef GetActorsCallBack = Future<List<Actor>> Function(String movieId);

class ActorsNotifier extends StateNotifier<Map<String, List<Actor>>>{
  final GetActorsCallBack fetchActors;
  ActorsNotifier({required this.fetchActors}) : super( {} );

  Future<void> loadActors( String movieId ) async {

    final List<Actor> actors = await fetchActors(movieId);

    state = { ...state, movieId : actors };
    
  }
  
}
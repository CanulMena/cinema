
import 'package:cinema/domain/entities/actor.dart';

abstract class ActorsDataSource{
  Future<List<Actor>> getActorsByMoive( String movieId );
}
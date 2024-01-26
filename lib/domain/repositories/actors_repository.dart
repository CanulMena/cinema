import 'package:cinema/domain/entities/actor.dart';

abstract class ActorsRepository{

  Future<List<Actor>> getActorsByMoive( String movieId ); //al hacer abstract la clase no tengo que agregar un cuerpo al la funcion
}
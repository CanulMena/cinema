
import 'package:cinema/config/constants/enviroment.dart';
import 'package:cinema/domain/datasource/actors_datasource.dart';
import 'package:cinema/domain/entities/actor.dart';
import 'package:cinema/infrastructure/mappers/actor_mapper.dart';
import 'package:cinema/infrastructure/models/moviedb/movie_actors.dart';
import 'package:dio/dio.dart';

class ActorMovieDbDatasource extends ActorsDataSource{

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key' : Enviroment.movieDbKey
      }
    )
  );

  @override
  Future<List<Actor>> getActorsByMoive( String movieId ) async {
    final response = await dio.get('/movie/$movieId/credits');
    final movieActors = MovieActors.fromJson(response.data);
    final List<Actor> actors = movieActors.cast.map((e) => ActorMaper.castToEntity(e)).toList();
    return actors;
  }
}
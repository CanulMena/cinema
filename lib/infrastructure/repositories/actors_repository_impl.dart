import 'package:cinema/domain/datasource/actors_datasource.dart';
import 'package:cinema/domain/entities/actor.dart';
import 'package:cinema/domain/repositories/actors_repository.dart';

class ActorsRepositoryImpl extends ActorsRepository{

  final ActorsDataSource datasource;

  ActorsRepositoryImpl({required this.datasource});

  @override
  Future<List<Actor>> getActorsByMoive(String movieId) {
    return datasource.getActorsByMoive(movieId);
  }

}
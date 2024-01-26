
import 'package:cinema/infrastructure/datasource/actor_moviedb_datasource.dart';
import 'package:cinema/infrastructure/repositories/actors_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorRepositoryProvider = Provider((ref) => ActorsRepositoryImpl(datasource: ActorMovieDbDatasource()));
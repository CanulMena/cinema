import 'package:cinema/domain/entities/movie.dart';

abstract class  MoviesDatasource {

  Future<List<Movie>> getNowPlaying({ int page = 1 }); //estas son las reglas o los requisitos para hacer un getNowPlaying

}
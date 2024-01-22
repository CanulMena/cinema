import 'package:cinema/domain/entities/movie.dart';

abstract class  MoviesDatasource {

  Future<List<Movie>> getNowPlaying({ int page = 1 }); //*estas son las reglas o los requisitos para hacer un getNowPlaying

  Future<List<Movie>> getPopular({ int page = 1 }); //*nunca quitamos el async para dejar la referencia del future

  Future<List<Movie>> topReated({ int page = 1 }); //*nunca quitamos el async para dejar la referencia del future

  Future<List<Movie>> upcoming({ int page = 1 }); //*nunca quitamos el async para dejar la referencia del future

} 
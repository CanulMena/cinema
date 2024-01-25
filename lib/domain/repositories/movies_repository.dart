
import 'package:cinema/domain/entities/movie.dart';

abstract class MoviesRepository {

  Future<List<Movie>> getNowPlaying({ int page = 1});

  Future<List<Movie>> getPopular({ int page = 1});

  Future<List<Movie>> getTopReated({ int page = 1});

  Future<List<Movie>> getUpcoming({ int page = 1});

  Future<Movie> getDetailMovie( String id );
  
}
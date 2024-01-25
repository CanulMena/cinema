import 'package:cinema/domain/datasource/movies_datasource.dart';
import 'package:cinema/domain/entities/movie.dart';
import 'package:cinema/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {

  final MoviesDatasource datasource;

  MovieRepositoryImpl(this.datasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) { //*No agregamos el asyng para solo obtener la referencia
    return datasource.getNowPlaying( page: page);
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) { //*No agregamos el asyng para solo obtener la referencia
    return datasource.getPopular( page: page );
  }
  
  @override
  Future<List<Movie>> getTopReated({int page = 1}) { //*No agregamos el asyng para solo obtener la referencia
    return datasource.topReated( page: page );
  }
  
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) { //*No agregamos el asyng para solo obtener la referencia
    return datasource.upcoming( page: page );
  }
  
  @override
  Future<Movie> getDetailMovie(String id) {
    return datasource.getDetailMovie( id ) ;
  }
  


}
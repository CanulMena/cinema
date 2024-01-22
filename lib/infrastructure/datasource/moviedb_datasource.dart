
import 'package:cinema/config/constants/enviroment.dart';
import 'package:cinema/domain/datasource/movies_datasource.dart';
import 'package:cinema/domain/entities/movie.dart';
import 'package:cinema/infrastructure/mappers/movie_mapper.dart';
import 'package:cinema/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDatasource {

  final Dio dio = Dio(//*cada que utilicemos esta instancia ya estarán configuradas las BaseOptions
    /*aca podemos hacer configuraciones globales*/
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',//*Esta es la base que la api siempre mantendrá. de aqui haremos implementaciones a la forma que queramos
      queryParameters: {
        "api_key" : Enviroment.movieDbKey,
        "language" : "es-MX"
      }
    ));

  @override//!1
  Future<List<Movie>> getNowPlaying({int page = 1}) async {

    final response = await dio.get('/movie/now_playing',
    queryParameters: {
      'page' : page 
    }
    );

    final movieDbResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDbResponse.results
    .where((moviedb) => moviedb.posterPath != 'no-poster')
    .map(
      (e) => MovieMapper.movieDBToEntity(e)
    ).toList();

    return movies;
    //esto se puede tomar como una lista de peliculas: <Movie> []
  }
  
  @override//!2
  Future<List<Movie>> getPopular({int page = 1}) async { //*al usar el async quitamos la referencia Future
    final response = await dio.get('/movie/popular',
    queryParameters: {
      'page' : page
    }
    );//Tenemos que esperar a que termine de obtener la data de la peticion
    final movieDbResponse = MovieDbResponse.fromJson(response.data);//comprobamos que modelo del la peticion sea el correcto - ahí mismo esta el modelo de moviemoviedb
    final List<Movie> movies = movieDbResponse.results
    .map(
      (e) => MovieMapper.movieDBToEntity(e)
    ).toList();
    
    return movies;
  }
  
  @override//!3
  Future<List<Movie>> topReated({int page = 1}) async { //*al usar el async quitamos la referencia Future
  final response = await dio.get('/movie/top_rated', //? Por que tengo que poner el await para que haga la peticion? sino me tira que es otro tipo de dato
  queryParameters: {
    'page' : page
  }
  );
  final movieDbResponse = MovieDbResponse.fromJson(response.data);
  //*mapeamos cada List<movieMovieDb> la propiedad result de MovieDbResponnse y convertimos cada movieMovieDb a mi entidad Movie luego cada Movie lo convertimos a una lista. 
  final List<Movie> movies = movieDbResponse.results.map((e) => MovieMapper.movieDBToEntity(e)).toList();
    return movies;
  }
  
  @override
  Future<List<Movie>> upcoming({int page = 1}) async {  //*al usar el async quitamos la referencia Future
  final response = await dio.get('/movie/upcoming',
  queryParameters: {
    "page": page
  }
  );

  final movieDbReponse = MovieDbResponse.fromJson(response.data);
  final List<Movie> movies = movieDbReponse.results.map((e) => MovieMapper.movieDBToEntity(e)).toList();
    return movies;
  }

}

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

  @override
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

}
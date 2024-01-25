import 'package:cinema/domain/entities/movie.dart';
import 'package:cinema/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinema/infrastructure/models/moviedb/movie_moviedb.dart';

/*
!Esta es una capa de proteccion con el api que viene afuera con nuestra aplicacion. es por esa razon por la que usamos nuestra entidad
*La idea del movie maper es que podamos crear un movie basado en algun tipo de objeto que vamos a recibira venga de MovieDB o de IMDB o cualquier lado */
class MovieMapper {
  //Estas conviertiendo trasnformando  MovieMovieDB a los valores que recibe mi entiedad - mis reglas de negocio
  static Movie movieDBToEntity(MovieMovieDB moviedb) => Movie(
      adult: moviedb.adult,
      backdropPath: (moviedb.backdropPath != '')
          ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
          : 'https://ih0.redbubble.net/image.4905811447.8675/raf,360x360,075,t,fafafa:ca443f4786.jpg',
      genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
      id: moviedb.id,
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      posterPath: (moviedb.posterPath != '')
          ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
          : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTi7MdCF1KEsTUCfWsA_7Z2nsWaIo7CBlhOaw&usqp=CAU',
      releaseDate: moviedb.releaseDate,
      title: moviedb.title,
      video: moviedb.video,
      voteAverage: moviedb.voteAverage,
      voteCount: moviedb.voteCount);
//*El objetivo como tal es tomar la implementacion especifica de MovieMovieDb para que me sirva a mi para transformarlo a mi entidad

  static Movie movieDetailToEntity(MovieDetails moviedb) => Movie(
      adult: moviedb.adult,
      backdropPath: (moviedb.backdropPath != '')
          ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
          : 'https://ih0.redbubble.net/image.4905811447.8675/raf,360x360,075,t,fafafa:ca443f4786.jpg',
      genreIds: moviedb.genres.map((e) => e.name.toString() ).toList(),
      id: moviedb.id,
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      posterPath: (moviedb.posterPath != '')
          ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
          : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTi7MdCF1KEsTUCfWsA_7Z2nsWaIo7CBlhOaw&usqp=CAU',
      releaseDate: moviedb.releaseDate,
      title: moviedb.title,
      video: moviedb.video,
      voteAverage: moviedb.voteAverage,
      voteCount: moviedb.voteCount);
  

}

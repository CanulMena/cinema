
import 'package:cinema/domain/entities/movie.dart';
import 'package:cinema/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieDetailsProvider = StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider).getDetailMovie;
  return MovieMapNotifier(
    getMovie: movieRepository
  );
});


/*
  {
    '5023' : Movie() - instancia de movie;
    '5024' : Movie() - instancia de movie;
    '5025' : Movie() - instancia de movie;
  }
 */

typedef GetMovieCallBack = Future<Movie>Function(String movieId);



class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {

  final GetMovieCallBack getMovie;

  MovieMapNotifier({required this.getMovie}) : super( {} );

  Future<void> loadMovieDetail( String movieId ) async {
    if(state[movieId] != null) return;
    print('realizando peticion http');
    final movie = await getMovie(movieId);

    state = {...state, movieId: movie};
  }
}
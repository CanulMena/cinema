import 'package:cinema/domain/entities/movie.dart';
import 'package:cinema/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  //hace referencia a la funcion - no la ejecutamos
  final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getNowPlaying;

  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
    );
  });



typedef MovieCallBack = Future<List<Movie>> Function({ int page }); //!Esta fuera del MoviesStateNotifier - creamos una referencia



class MoviesNotifier extends StateNotifier<List<Movie>>{
  
  bool isLoading = false;
  int currentPage = 0; 
  MovieCallBack fetchMoreMovies;

  MoviesNotifier({
    required this.fetchMoreMovies
  }): super([]);

  Future<void> loadNextPage() async{ 
    if( isLoading ) return; //si es verdadero cerramos la funcion

    isLoading = true;
    currentPage++; //nos cambiamos a la otra pagina
    final List<Movie> movies = await fetchMoreMovies(page: currentPage); //aca ejecutamos la funcion
    state = [...state, ...movies];
    isLoading = false;//se cambia a false para que se pueda iterar
  }
}


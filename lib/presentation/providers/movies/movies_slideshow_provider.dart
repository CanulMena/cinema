import 'package:cinema/domain/entities/movie.dart';
import 'package:cinema/presentation/providers/movies/movies_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final moviesSlideShowProvider = Provider<List<Movie>>((ref) {
  //haremos cambios en el estado de una manera directa - por eso utilizamos watch
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

  if(nowPlayingMovies.isEmpty) return [];

  return nowPlayingMovies.sublist(0, 6);

});

import 'package:animate_do/animate_do.dart';
import 'package:cinema/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


typedef SearchMovieCallBack = Future<List<Movie>> Function( String query );

class SearchMoviesDelegate extends SearchDelegate<Movie?>{ 
//*El search delegate ya nos ofrece el query.

  final SearchMovieCallBack searchMovie;

  SearchMoviesDelegate({required this.searchMovie}); 

  @override
  String? get searchFieldLabel => 'Buscar' ; 

  @override
  List<Widget>? buildActions(BuildContext context) {//*<Widget>[] derecho appbar
    return [
      FadeIn(
        animate: query.isNotEmpty,
        child: IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.close)
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) { //*widget izquierdo appbar
    return IconButton(
      onPressed: () {
        close(context, null); //<--- no se por que tuve que agregar null aquí
      }, 
      icon: const Icon(Icons.arrow_back_ios)
      );
  }

  @override
  Widget buildResults(BuildContext context) { //*Informacion inferior despues de buscar -- regresa la pelicula
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) { //*Informacion inferior antes de buscar -- busca la pelicula
    return FutureBuilder(//no sirve para ejecutar funciones future - trabajar con futures
      future: searchMovie(query), 
      builder: (context, snapshot) {
        final movies  = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index] ;
            return GestureDetector(
              onTap: () => context.go('/movie/${movie.id}'),
              child: ListTile(
                title: Text(movie.title),
              ),
            );
          },
        );
      },
    );
  }

}
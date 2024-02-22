
import 'package:animate_do/animate_do.dart';
import 'package:cinema/config/helpers/human_formats.dart';
import 'package:cinema/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


typedef SearchMovieCallBack = Future<List<Movie>> Function( String query );

class SearchMoviesDelegate extends SearchDelegate<Movie?>{ 
//*El search delegate ya nos ofrece el query.
  //?Hola me llamo chavito gustavo 
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
              child: _MovieItem(movie: movie),
            );
          },
        );
      },
    );
  }

}

class _MovieItem extends StatelessWidget {
  const _MovieItem({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;  
    return Padding(
      padding: const EdgeInsets.symmetric( horizontal: 10 , vertical: 5 ),
      child: Row(
        children: [

          //Image 
          SizedBox(
            width: size.width * 0.20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                loadingBuilder: (context, child, loadingProgress) {
                  if(loadingProgress != null) return const Center(child: CircularProgressIndicator());
                  return FadeIn(child: child);
                },
              ),
            ),
          ),

          const SizedBox(
            width: 10,
          ),
          //Description
          SizedBox(
            width: size.width * 0.7,
            child: Column(//especificar el tamaño de los widgets
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.originalTitle, style: textStyle.titleMedium,),

                (movie.overview.length >= 100)
                ? Text('${movie.overview.substring(0, 100)}...') 
                : Text(movie.overview),

                Row(
                  children: [
                    Icon(Icons.star_half, color: Colors.yellow.shade800,),
                    const SizedBox( width: 2, ),
                    Text(
                      HumanFormats.number(movie.voteAverage, 1), 
                      style: textStyle.bodyMedium!.copyWith(color: Colors.yellow.shade800),
                    )
                  ],
                )
              ],
            ),
          )


        ],
      )
    );
  }
}
import 'package:cinema/domain/entities/movie.dart';
import 'package:cinema/presentation/providers/movies/movie_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen';

  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    ref.read(movieDetailsProvider.notifier).loadMovieDetail(widget.movieId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //movieDetails esta haciendo referencia del mapa
    final movieMapDetails = ref.watch(movieDetailsProvider);
    final movieDetail = movieMapDetails[widget.movieId];//movieDetail tiene el movie que regresa el http
    //esperamos a hacer la peticion http - para mostrar lo que queramos
    if (movieDetail == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView( //? Sin los custtomScrollView no puedo hacer uso de los Slivers
        slivers: [
          _CustomSliver(
            movie: movieDetail,
          ), 
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 1,
              (context, index) => _MovieDetails( movieDetail: movieDetail,)
              )
            )
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movieDetail;
  const _MovieDetails({required this.movieDetail});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movieDetail.posterPath,
                  width: size.width * 0.3,
                  ),
              ),
        
              const SizedBox(width: 10,),

              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(//siempre tengo que predefinir el tamaño que tomarán los widgets - (width)
                  children: [
                    Text(movieDetail.title, style: textStyle.titleLarge,),
              
                    Text(movieDetail.overview),
                  ],
                ),
              )
              
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap( //gracias a wrap agrega un margin o padding en el bottom
            children: [
            ...movieDetail.genreIds.map((genre) => Container(
              margin: const EdgeInsets.only(right: 10),
              child: Chip(
                label: Text(genre),
                shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20) ),
                )
            ),)
            ],
          ),
        ),

        const SizedBox(height: 100,),

      ],
    );
  }
}



class _CustomSliver extends StatelessWidget {
  final Movie movie;
  const _CustomSliver({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      floating: true,
      expandedHeight: size.height * 0.7, //controlar la altura del sliverAppbar
      foregroundColor:
          Colors.white, //el color predefinido de las letras y iconos
      backgroundColor: Colors.white, //color de fondo
      flexibleSpace: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: FlexibleSpaceBar(
            titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            title: Text(
              movie.title,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.start,
            ),
            background: Stack(
              children: [
                SizedBox.expand(//Tengo que predefinir el tamaño de la foto
                  child: Image.network(
                    movie.posterPath,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox.expand(
                  child: DecoratedBox(//tengo que predefinir el tamaño del decoretedbox
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        stops: [
                          0.65, 1.0
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black87
                        ]
                      )
                    )
                  ),
                ),
                const SizedBox.expand(
                  child: DecoratedBox(//tengo que predefinir el tamaño del decoretedbox
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        stops: [
                          0.0, 0.3
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.black87,
                          Colors.transparent,
                        ]
                      )
                    )
                  ),
                )
              ],
            )
        ),
      ),
    );
  }
}

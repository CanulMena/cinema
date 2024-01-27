import 'package:animate_do/animate_do.dart';
import 'package:cinema/domain/entities/movie.dart';
import 'package:cinema/presentation/providers/actors/actors_providers.dart';
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
    ref.read(actorsMovieProvider.notifier).loadActors(widget.movieId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //? final movieMapDetails = ref.watch(movieDetailsProvider)[widget.movieId];
    final movieMapDetails = ref.watch(movieDetailsProvider);
    final movieDetail = movieMapDetails[widget.movieId];
    //esperamos a hacer la peticion http - para mostrar lo que queramos
    if (movieDetail == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        //? Sin los custtomScrollView no puedo hacer uso de los Slivers
        slivers: [
          _CustomSliverAppBar(
            movie: movieDetail,
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  childCount: 1,
                  (context, index) => _MovieDetails(
                        movieDetail: movieDetail,
                      ))),
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
          //*Detalles de la pelicula
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
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  //siempre tengo que predefinir el tamaño que tomarán los widgets - (width)
                  children: [
                    Text(
                      movieDetail.title,
                      style: textStyle.titleLarge,
                    ),
                    Text(movieDetail.overview),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          //*Generos de la pelicula
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            children: [
              ...movieDetail.genreIds.map(
                (genre) => Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Chip(
                      label: Text(genre),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    )),
              )
            ],
          ),
        ),

        const SizedBox(
          height: 10,
        ),

        _ActorsByMovie(
          movieId: movieDetail.id.toString(),
        ),
        

      ],
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final String movieId;
  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actorsByMovie = ref.watch(actorsMovieProvider);
    if (actorsByMovie[movieId] == null) {
      return const CircularProgressIndicator(strokeWidth: 2);
    }
    final actors = actorsByMovie[movieId];

    return SizedBox(
      //el tamaño de todo el contenedor que tendrá todo
      height: 300,
      child: ListView.builder(
        //!Tengo que definir la altura del ListView.builder
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: actors!.length,
        itemBuilder: (context, index) {
          final actor = actors[index];
          return Container(
              //*Contenedor principal
              padding: const EdgeInsets.all(8),
              child: FadeInRight(
                child: Column(
                  //!tengo que predefinir la altura de una columna
                  children: [
                    ClipRRect(
                      //image container
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        actor.profilePath,
                        height: 190,
                        width: 135,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: 135,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                          actor.name,
                          maxLines: 2,
                          ),
                          Text(
                            actor.character,
                            style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                            softWrap: true,
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ));
        },
      ),
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final Movie movie;
  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      // floating: true,
      expandedHeight: size.height * 0.7, //controlar la altura del sliverAppbar
      foregroundColor:
          Colors.white, //el color predefinido de las letras y iconos
      backgroundColor: Colors.black, //color de fondo
      flexibleSpace: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: FlexibleSpaceBar(
            titlePadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            title: Text(
              movie.title,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.start,
            ),
            background: Stack(
              children: [

                SizedBox.expand(
                  //Tengo que predefinir el tamaño de la foto
                  child: Image.network(
                    movie.posterPath,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if( loadingProgress != null) return const SizedBox();
                      return FadeIn(child: child);
                    },
                  ),
                ),

                const SizedBox.expand(
                  child: DecoratedBox(
                      //tengo que predefinir el tamaño del decoretedbox
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              stops: [0.65, 1.0],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black87]))),
                ),
                const SizedBox.expand(
                  child: DecoratedBox(
                      //tengo que predefinir el tamaño del decoretedbox
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              stops: [0.0, 0.3],
                              begin: Alignment.topLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.black87,
                                Colors.transparent,
                              ]))),
                )
              ],
            )),
      ),
    );
  }
}

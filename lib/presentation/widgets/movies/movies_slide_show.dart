import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cinema/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MoviesSlideShow extends StatelessWidget {
  final List<Movie> movies;

  const MoviesSlideShow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      height: 210,
      child: Swiper(//toma el espacio disponible - espacio del sizebox
        itemCount: movies.length,
        viewportFraction: 0.8, //ancho de la pantalla que tomará el item
        scale: 0.9, //cuanto se verán los otros items por los lados
        itemBuilder: (context, index) {
          final movie = movies[index];
          return _Slide(
            movie: movie,
          ); //toma el espacio disponible
        },
        pagination: SwiperPagination(//existen mas tipos de swiper
          builder: DotSwiperPaginationBuilder(//tiene mas tipos para mostrar la pantalla
            activeColor: colors.primary,
            color: colors.secondary
          )
        )
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    Decoration decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
              color: Colors.black45,
              blurRadius: 10, //difuminado del color
              offset: Offset(0, 12) //pocision de la sombra
              )
        ]);

    return Padding(
      padding: const EdgeInsets.only(bottom: 31),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            movie.backdropPath,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress != null) {
                return DecoratedBox(decoration: decoration);
              }
              return FadeIn(child: child);
            },
          ),
        ),
      ),
    );
  }
}

import 'package:animate_do/animate_do.dart';
import 'package:cinema/config/helpers/human_formats.dart';
import 'package:cinema/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MoviesHorizontalListView extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage; //este tipo de valor tiene una funcion - puede ser activdada desde aquí 
  //gracias a este voidCallBack que activamos por la funcion que pasamos podemos hacer que nuetro codigo no dependa de un gestor de estado. Así lo hacemos independiente

  const MoviesHorizontalListView(
      {super.key,
      required this.movies,
      this.title,
      this.subTitle,
      this.loadNextPage});

  @override
  State<MoviesHorizontalListView> createState() =>
      _MoviesHorizontalListViewState();
}

class _MoviesHorizontalListViewState extends State<MoviesHorizontalListView> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    //?Por que tenemos que agregar un addListener? -- tienes que estar pendiente que hagamos scroll ( los pixeles de la pantalla )
    scrollController.addListener(() {
      if (widget.loadNextPage == null) return; //Al agregar argumentos en la propiedad del widget siemrpe será null.
      if(scrollController.position.pixels + 200 >= scrollController.position.maxScrollExtent){
        widget.loadNextPage!();//si cumple la condicion, ejecutamos la función que le agregaremos al parametro
      }
    });
  }

  @override
  void dispose() {
    scrollController
        .dispose(); //*eliminamos el controller antes que se destruya el widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(//siempre definir el tamaño de un widget
        children: [
          if (widget.title != null || widget.subTitle != null)
            _Tile(
              title: widget.title,
              subTitle: widget.subTitle,
            ),
          Expanded(
            //*Utilizamos el expanded para indicarle al listview cuanto espacio vertical / horizontal tomará
            child: ListView.builder(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (context, index) {
                final movie = widget.movies[index];
                return FadeInRight(child: _Slide(movie: movie));
              },
            ),
          )
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final String? title;
  final String? subTitle;

  const _Tile({required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleLarge;
    return Container(
      //*Utilizar el container para tener mas flexibilidad en el codigo.
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          if (title != null)
            Text(
              title!,
              style: textStyle,
            ),
          const Spacer(),
          if (subTitle != null)
            FilledButton.tonal(
                style: const ButtonStyle(visualDensity: VisualDensity.compact),
                onPressed: () {},
                child: Text(subTitle!))
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            
            SizedBox(//* image movie container
              width: 150, //al estar invertido, el width del listView es la altura              
              child: ClipRRect(
                //Tengo que agregarle el espacio que tomará como limite - Tarea del sizebox
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) {
                      return const SizedBox(
                        height: 150,
                        child: Center(
                          child: CircularProgressIndicator( //?Aca tengo que arreglar el error
                            strokeWidth: 2,
                          ),
                        ),
                      );
                    }
                    return GestureDetector(
                      onTap: () => context.push('/movie/${movie.id}'),
                      child: FadeIn(
                        child: child,
                      ),
                    );
                  },
                ),
              ),
            ),

            Container( //*title, calification movie - container
              width: 150,
              margin: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Text(
                    movie.title,
                    style: textStyles.titleSmall,
                    maxLines: 2,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star_half_outlined,
                        color: Colors.yellow.shade800,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text('${movie.voteAverage}',
                          style: textStyles.bodyMedium
                              ?.copyWith(color: Colors.yellow.shade800)),
                      const Spacer(),
                      Text(HumanFormats.number(movie.popularity),
                          style: textStyles.bodyMedium),
                    ],
                  )
                ],
              ),
            )

          ],
        ));
  }
}

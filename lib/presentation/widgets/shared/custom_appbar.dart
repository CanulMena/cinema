import 'package:cinema/presentation/delegates/search_movie_delegate.dart';
import 'package:cinema/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            const Icon(Icons.movie_creation_outlined),
            const SizedBox(
              width: 5,
            ),
            Text(
              'Cinemedia',
              style: titleStyle,
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  showSearch(
                      //*Esta funcion es la encargada en trabajar la busqueda
                      context: context,
                      delegate: SearchMoviesDelegate(
                          searchMovie:
                              ref.read(movieRepositoryProvider).searchMovies));
                },
                icon: const Icon(Icons.search_rounded))
          ],
        ),
      ),
    ));
  }
}

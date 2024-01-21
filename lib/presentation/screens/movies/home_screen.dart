import 'package:cinema/presentation/providers/providers.dart'; //!Siempre usar nuestro archivo de barril - provider
import 'package:cinema/presentation/widgets/widgets.dart'; //!Siempre usar nuestro archivo de barril - widgets
import 'package:cinema/presentation/widgets/shared/custom_botton_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    //ejecuta la funcion, la funcion obtiene las listas - no modificamos el estado de una menera dircta
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final moviesSlideShow = ref.watch(moviesSlideShowProvider);
    return Scaffold(
        body: CustomScrollView(
          //podremos tener control sobre los Sliver - un Sliver es un widget que trabaja directamente con el scrollView
          slivers: [
            const SliverAppBar(
            floating: true,
            flexibleSpace: FlexibleSpaceBar(//!Aprender a usar esta propiedad y el FelixibleSpaceBar - Al igual se aprender a usar los Flexible
              centerTitle: true,
              title: CustomAppbar(),
            ),
          ),
            SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              return Column(
                children: [
                  MoviesSlideShow(movies: moviesSlideShow),
                  MoviesHorizontalListView(
                    movies: nowPlayingMovies,
                    title: 'En cines',
                    subTitle: 'Este mes',
                    loadNextPage: () {
                      ref
                          .read(nowPlayingMoviesProvider.notifier)
                          .loadNextPage();
                    },
                  ),
                  MoviesHorizontalListView(
                    movies: nowPlayingMovies,
                    title: 'Populares',
                    subTitle: 'Este mes',
                    loadNextPage: () {
                      ref
                          .read(nowPlayingMoviesProvider.notifier)
                          .loadNextPage();
                    },
                  ),
                  MoviesHorizontalListView(
                    movies: nowPlayingMovies,
                    title: 'Proximamente',
                    loadNextPage: () {
                      ref
                          .read(nowPlayingMoviesProvider.notifier)
                          .loadNextPage();
                    },
                  ),
                ],
              );
            }, childCount: 1))
          ],
        ),
        bottomNavigationBar: const CustomBottonNavigation());
  }
}

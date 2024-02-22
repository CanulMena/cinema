import 'package:cinema/presentation/providers/movies/initial_loading_provider.dart';
import 'package:cinema/presentation/providers/providers.dart'; //!Siempre usar nuestro archivo de barril - provider
import 'package:cinema/presentation/widgets/shared/full_screen_loading.dart';
import 'package:cinema/presentation/widgets/widgets.dart'; //!Siempre usar nuestro archivo de barril - widgets
import 'package:cinema/presentation/widgets/shared/custom_botton_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: _HomeView(), 
        
        bottomNavigationBar: CustomBottonNavigation());
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    //ejecuta la funcion, la funcion obtiene las listas - no modificamos el estado de una menera dircta
    ref
        .read(nowPlayingMoviesProvider.notifier)
        .loadNextPage(); //*Ejecutamos la funcion para hacer la peticion
    ref
        .read(popularMoviesProvider.notifier)
        .loadNextPage(); //*Ejecutamos la funcion para hacer la peticion
    ref.read(topReatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topReatedMovies = ref.watch(topReatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final moviesSlideShow = ref.watch(moviesSlideShowProvider);

    final initialLoading = ref.watch(initialLoadingProvider);
    if( initialLoading ) return const FullScreenLoading();
    
    return CustomScrollView(
      //podremos tener control sobre los Sliver - un Sliver es un widget que trabaja directamente con el scrollView
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            //!Aprender a usar esta propiedad y el FelixibleSpaceBar - Al igual se aprender a usar los Flexible
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
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                },
              ),
              MoviesHorizontalListView(
                movies: popularMovies,
                title: 'Populares',
                subTitle: 'Este mes',
                loadNextPage: () {
                  ref.read(popularMoviesProvider.notifier).loadNextPage();
                },
              ),
              MoviesHorizontalListView(
                movies: topReatedMovies,
                title: 'Mas valorados',
                loadNextPage: () {
                  ref.read(topReatedMoviesProvider.notifier).loadNextPage();
                },
              ),
              MoviesHorizontalListView(
                movies: upcomingMovies,
                title: 'Proximamente',
                loadNextPage: () {
                  ref
                      .read(upcomingMoviesProvider
                          .notifier) //usamos read en el uso del provider por que no estamos utilizando el estado del provider de una manera directa
                      .loadNextPage();
                },
              ),
            ],
          );
        }, childCount: 1))
      ],
    );
  }
}

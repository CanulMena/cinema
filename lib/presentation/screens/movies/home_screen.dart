import 'package:cinema/presentation/providers/providers.dart'; //!Siempre usar nuestro archivo de barril - provider
import 'package:cinema/presentation/widgets/movies/movies_slide_show.dart';
import 'package:cinema/presentation/widgets/shared/custom_botton_navigation.dart';
import 'package:cinema/presentation/widgets/widgets.dart';
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
    //?por que no podemos usar ref.watch?
    //ejecuta la funcion, la funcion obtiene las listas - no modificamos el estado de una menera dircta
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final moviesSlideShow = ref.watch(moviesSlideShowProvider);

    return Scaffold(
        body: Column(
          children: [
            const CustomAppbar(),
            MoviesSlideShow(movies: moviesSlideShow),
            
          ],
        ),
        bottomNavigationBar: const CustomBottonNavigation());
  }
}

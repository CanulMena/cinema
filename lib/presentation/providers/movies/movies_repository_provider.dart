import 'package:cinema/infrastructure/datasource/moviedb_datasource.dart';
import 'package:cinema/infrastructure/repositories/movies_respository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Este repositorio es inmutable ya que no vamos a cambiar su estado (MoviedbDatasource())
final movieRepositoryProvider = Provider((ref){
  return MovieRepositoryImpl( MoviedbDatasource() );
}); 

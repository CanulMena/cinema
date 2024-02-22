import 'package:flutter_dotenv/flutter_dotenv.dart';



class Enviroment{

  //*en esta clase tendremos la variables de entorno predefinidas para no tener problemas al momento de llamarlas
  //de igual forma lo agregamos de una maner estatica para no tener que crear una instancia para poder usar la variable

  static String movieDbKey = dotenv.env['THE_MOVIEDB_KEY'] ?? 'dont exist movieDbKey';



}
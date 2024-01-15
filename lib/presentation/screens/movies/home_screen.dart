import 'package:cinema/config/constants/enviroment.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        //*Esta es una buena forma de llamar a las variables de entorno por medio del paquete flutter_dontenv
        child: Text(Enviroment.movieDbKey),
      ),
    );
  }
}
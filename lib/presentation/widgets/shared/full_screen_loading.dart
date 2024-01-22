import 'package:flutter/material.dart';

class FullScreenLoading extends StatelessWidget {
  const FullScreenLoading({super.key});

  Stream stream(){

    List<String> messages = [
      'cargando peliculas...',
      'ya mero...',
      'esta tardando mas de lo esperado :('
    ];
    // La informacion que se regresará del step es el snapshot.data - es el return messages[step]
    return Stream.periodic( const Duration(milliseconds: 2000 ), (step) {
      return messages[step];
    })
      .take(messages.length);

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 10,),
          StreamBuilder(
            stream: stream(), 
            builder: (context, snapshot) {
              if( !snapshot.hasData ) return const Text('cargando...');
              return Text(snapshot.data!);
            },
            )
        ],
      ),
    );
  }
}